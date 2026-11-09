"use client";

import { useProgress } from "@/lib/progress";

// Mastery-style progress: one dot per skill check, filled when answered
// correctly. Status is spelled out in words as well as shown by color, so it
// does not depend on seeing color.

export function SkillDots({ questionIds }: { questionIds: string[] }) {
  const progress = useProgress();
  const total = questionIds.length;
  const done = questionIds.filter((id) => progress[id]?.correct).length;
  const status =
    total > 0 && done === total
      ? "Lesson complete"
      : done > 0
        ? "In progress"
        : "Not started";

  return (
    <div>
      <div className="flex flex-wrap gap-1.5" aria-hidden="true">
        {questionIds.map((id) => (
          <span
            key={id}
            className={`h-3 w-3 rounded-full border-2 ${
              progress[id]?.correct
                ? "border-indigo-600 bg-indigo-600"
                : "border-slate-300 bg-white"
            }`}
          />
        ))}
      </div>
      <p className="mt-2 text-sm font-medium text-slate-700">
        <span
          className={
            status === "Lesson complete" ? "text-green-800" : "text-slate-700"
          }
        >
          {status}
        </span>
        <span className="text-slate-500">
          {" "}
          · {done} of {total} skills
        </span>
      </p>
    </div>
  );
}

export function OverallProgress({ questionIds }: { questionIds: string[] }) {
  const progress = useProgress();
  const total = questionIds.length;
  const done = questionIds.filter((id) => progress[id]?.correct).length;
  const percent = total === 0 ? 0 : Math.round((done / total) * 100);

  return (
    <div className="mt-8 max-w-md">
      <div className="flex items-baseline justify-between text-sm font-medium text-indigo-100">
        <span>Your progress</span>
        <span>
          {done} of {total} skills
        </span>
      </div>
      <div
        className="mt-2 h-3 overflow-hidden rounded-full bg-indigo-900"
        role="progressbar"
        aria-label="Overall progress"
        aria-valuemin={0}
        aria-valuemax={total}
        aria-valuenow={done}
      >
        <div
          className="h-full rounded-full bg-amber-300 transition-all"
          style={{ width: `${percent}%` }}
        />
      </div>
    </div>
  );
}
