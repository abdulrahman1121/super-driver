"use client";

import { useMemo, useSyncExternalStore } from "react";

// DEMO SHORTCUT (see "Temporary shortcuts and debt" in CLAUDE.md): progress is
// kept only in this browser's localStorage. The decided design is a Supabase
// progress table behind anonymous sign-in, with localStorage as a pending-saves
// queue. When that is built, this file becomes the queue, and the merge rule
// below ("best result per question") is reused for the server merge.

const KEY = "superdriver:progress:v1";

export type Progress = Record<string, { correct: boolean }>;

// If localStorage is blocked (private mode, storage full, disabled cookies) we
// still want progress to work for the current visit, so keep a copy in memory.
let memoryRaw = "";
const listeners = new Set<() => void>();

function emit() {
  listeners.forEach((l) => l());
}

function readRaw(): string {
  try {
    return window.localStorage.getItem(KEY) ?? memoryRaw;
  } catch {
    return memoryRaw;
  }
}

// Stored data is untrusted: it can be hand-edited, from an older version, or
// corrupted. Anything that does not match the expected shape is dropped.
export function parseProgress(raw: string): Progress {
  if (!raw) return {};
  try {
    const value: unknown = JSON.parse(raw);
    if (typeof value !== "object" || value === null || Array.isArray(value)) {
      return {};
    }
    const result: Progress = {};
    for (const [id, entry] of Object.entries(value)) {
      if (
        typeof entry === "object" &&
        entry !== null &&
        typeof (entry as { correct?: unknown }).correct === "boolean"
      ) {
        result[id] = { correct: (entry as { correct: boolean }).correct };
      }
    }
    return result;
  } catch {
    return {};
  }
}

// Merge rule: keep the best result per question. A correct answer is never
// replaced by a later wrong one.
export function recordResult(questionId: string, correct: boolean) {
  const current = parseProgress(readRaw());
  if (current[questionId]?.correct) return;
  current[questionId] = { correct };
  const raw = JSON.stringify(current);
  memoryRaw = raw;
  try {
    window.localStorage.setItem(KEY, raw);
  } catch {
    // Storage unavailable: progress lives in memory until the tab closes.
  }
  emit();
}

function subscribe(listener: () => void) {
  listeners.add(listener);
  // Also react to changes made in another tab.
  window.addEventListener("storage", listener);
  return () => {
    listeners.delete(listener);
    window.removeEventListener("storage", listener);
  };
}

// useSyncExternalStore needs a stable snapshot: a string is compared by value.
// On the server there is no storage, so progress starts empty and fills in
// after hydration.
export function useProgress(): Progress {
  const raw = useSyncExternalStore(subscribe, readRaw, () => "");
  return useMemo(() => parseProgress(raw), [raw]);
}
