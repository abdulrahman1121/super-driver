"use client";

import { useRef, useState, useSyncExternalStore } from "react";
import type { Question } from "@/lib/content";
import { recordResult, useProgress } from "@/lib/progress";
import { createSupabase } from "@/lib/supabase";
import { shuffleChoices } from "@/lib/shuffle";

// One skill check. The browser never holds the answer: choosing a choice calls
// the database function check_choice, which returns whether it was right and
// why. Every way that call can fail ends in a visible message with a retry
// button, never a silent hang.

type State =
  | { phase: "idle" }
  | { phase: "checking"; choiceId: string }
  | { phase: "done"; choiceId: string; correct: boolean; explanation: string }
  | { phase: "error"; choiceId: string; message: string };

// One random number per visit to the lesson (per mount of <Quiz>). On the server
// and during hydration it is 0, which means "not ready": the choices render in
// their stored order but stay hidden. As soon as the browser has it, the real
// seed is used and the shuffled choices appear. Entering the lesson again, even
// by client-side navigation, mounts <Quiz> again and so gets a new seed.
function useShuffleSeed(): number {
  const [store] = useState(() => {
    let seed = 0;
    return {
      subscribe: () => () => {},
      getSnapshot: () =>
        (seed = seed || Math.floor(Math.random() * 2 ** 31) + 1),
      getServerSnapshot: () => 0,
    };
  });
  return useSyncExternalStore(
    store.subscribe,
    store.getSnapshot,
    store.getServerSnapshot,
  );
}

function QuestionCard({
  question,
  number,
  seed,
}: {
  question: Question;
  number: number;
  seed: number;
}) {
  const [state, setState] = useState<State>({ phase: "idle" });
  const progress = useProgress();
  const alreadyCorrect = progress[question.id]?.correct === true;
  const busy = useRef(false);
  const choices = shuffleChoices(question.choices, seed, question.id);

  async function check(choiceId: string) {
    // Ignore clicks while a check is already running, so a double click cannot
    // send two requests or let an older reply overwrite a newer one.
    if (busy.current) return;
    busy.current = true;

    setState({ phase: "checking", choiceId });
    try {
      const { data, error } = await createSupabase().rpc("check_choice", {
        p_choice_id: choiceId,
      });
      if (error) throw new Error(error.message);
      // No row means the grader does not know this choice (e.g. content was
      // unpublished while the page was open).
      const row = data?.[0];
      if (!row) {
        setState({
          phase: "error",
          choiceId,
          message:
            "This question isn't available right now. Please reload the page.",
        });
        return;
      }
      recordResult(question.id, row.is_correct);
      setState({
        phase: "done",
        choiceId,
        correct: row.is_correct,
        explanation: row.explanation,
      });
    } catch {
      // Network down, timeout, or server error. Nothing was recorded.
      setState({
        phase: "error",
        choiceId,
        message:
          "We couldn't check your answer. Check your connection and try again.",
      });
    } finally {
      // Always release, even when the request failed, so Retry still works.
      busy.current = false;
    }
  }

  const locked =
    state.phase === "checking" || (state.phase === "done" && state.correct);
  const selectedId = state.phase === "idle" ? null : state.choiceId;

  return (
    <fieldset className="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm sm:p-6">
      <legend className="sr-only">Skill check {number}</legend>
      <div className="flex items-start justify-between gap-3">
        <p className="text-sm font-semibold text-indigo-800">
          Skill check {number}
        </p>
        {alreadyCorrect && (
          <span className="rounded-full bg-green-100 px-2.5 py-0.5 text-xs font-semibold text-green-900">
            ✓ Got it
          </span>
        )}
      </div>
      <p className="mt-1 text-lg font-semibold text-slate-900">
        {question.prompt}
      </p>

      <ul className={`mt-4 space-y-2.5 ${seed === 0 ? "invisible" : ""}`}>
        {choices.map((choice) => {
          const isSelected = selectedId === choice.id;
          const tone =
            isSelected && state.phase === "done"
              ? state.correct
                ? "border-green-600 bg-green-50"
                : "border-amber-500 bg-amber-50"
              : isSelected
                ? "border-indigo-600 bg-indigo-50"
                : "border-slate-300 bg-white hover:border-indigo-500 hover:bg-indigo-50";
          return (
            <li key={choice.id}>
              <button
                type="button"
                disabled={locked}
                aria-pressed={isSelected}
                onClick={() => check(choice.id)}
                className={`flex w-full items-center gap-3 rounded-xl border-2 px-4 py-3 text-left text-base text-slate-900 transition focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-700 disabled:cursor-default ${tone}`}
              >
                <span
                  className={`flex h-6 w-6 shrink-0 items-center justify-center rounded-full border-2 text-xs font-bold ${
                    isSelected && state.phase === "done"
                      ? state.correct
                        ? "border-green-600 bg-green-600 text-white"
                        : "border-amber-600 bg-amber-500 text-slate-900"
                      : "border-slate-400 text-transparent"
                  }`}
                  aria-hidden="true"
                >
                  {isSelected && state.phase === "done"
                    ? state.correct
                      ? "✓"
                      : "!"
                    : "•"}
                </span>
                {choice.body}
              </button>
            </li>
          );
        })}
      </ul>

      <div role="status" aria-live="polite" className="mt-4">
        {state.phase === "checking" && (
          <p className="text-slate-600">Checking…</p>
        )}
        {state.phase === "done" && (
          <div
            className={`rounded-xl p-4 ${
              state.correct
                ? "bg-green-50 text-green-950"
                : "bg-amber-50 text-amber-950"
            }`}
          >
            <p className="font-bold">
              {state.correct ? "Correct!" : "Not quite"}
            </p>
            <p className="mt-1">{state.explanation}</p>
            {!state.correct && (
              <button
                type="button"
                onClick={() => setState({ phase: "idle" })}
                className="mt-3 rounded-lg bg-indigo-600 px-4 py-2 font-semibold text-white hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-700"
              >
                Try again
              </button>
            )}
          </div>
        )}
        {state.phase === "error" && (
          <div className="rounded-xl bg-slate-100 p-4 text-slate-900">
            <p>{state.message}</p>
            <button
              type="button"
              onClick={() => check(state.choiceId)}
              className="mt-3 rounded-lg bg-indigo-600 px-4 py-2 font-semibold text-white hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-700"
            >
              Retry
            </button>
          </div>
        )}
      </div>
    </fieldset>
  );
}

export function Quiz({ questions }: { questions: Question[] }) {
  const seed = useShuffleSeed();
  return (
    <div className="mt-6 space-y-4">
      {questions.map((q, i) => (
        <QuestionCard key={q.id} question={q} number={i + 1} seed={seed} />
      ))}
    </div>
  );
}
