import Link from "next/link";
import { OverallProgress, SkillDots } from "@/components/SkillProgress";
import { getLessons } from "@/lib/content";

// ISR: this page is built once, then rebuilt in the background at most every 60
// seconds. Without this it would be frozen at build time, and lessons published
// later would not appear until the next deploy.
export const revalidate = 60;

export default async function Home() {
  const lessons = await getLessons();
  const allQuestionIds = lessons.flatMap((l) => l.questionIds);
  const first = lessons[0];

  return (
    <main>
      <section className="bg-indigo-950 text-white">
        <div className="mx-auto max-w-5xl px-4 py-12 sm:py-16">
          <p className="text-sm font-semibold tracking-wide text-indigo-200 uppercase">
            Washington State driver&apos;s ed
          </p>
          <h1 className="mt-3 max-w-2xl text-3xl font-bold tracking-tight sm:text-5xl">
            Get ready for the road, one skill at a time.
          </h1>
          <p className="mt-4 max-w-xl text-lg text-indigo-100">
            Short lessons, then quick checks after each one. Miss a question? No
            problem. Read the explanation and try again.
          </p>
          {first && (
            <Link
              href={`/lessons/${first.id}`}
              className="mt-7 inline-block rounded-lg bg-indigo-500 px-6 py-3 font-semibold text-white hover:bg-indigo-400 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-white"
            >
              Start lesson 1
            </Link>
          )}
          {allQuestionIds.length > 0 && (
            <OverallProgress questionIds={allQuestionIds} />
          )}
        </div>
      </section>

      <section id="lessons" className="mx-auto max-w-5xl px-4 py-10">
        <h2 className="text-2xl font-bold text-slate-900">Your course</h2>
        <p className="mt-1 text-slate-700">
          {lessons.length} lessons, {allQuestionIds.length} skill checks
        </p>

        {lessons.length === 0 ? (
          <p className="mt-6 rounded-xl border border-slate-200 bg-white p-6 text-slate-700">
            No lessons are available yet. Please check back soon.
          </p>
        ) : (
          <ol className="mt-6 grid gap-4 sm:grid-cols-2">
            {lessons.map((lesson) => (
              <li key={lesson.id}>
                <Link
                  href={`/lessons/${lesson.id}`}
                  className="flex h-full flex-col gap-3 rounded-2xl border border-slate-200 bg-white p-5 shadow-sm transition hover:-translate-y-0.5 hover:border-indigo-500 hover:shadow-md focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-700"
                >
                  <span className="text-sm font-semibold text-indigo-800">
                    Lesson {lesson.position}
                  </span>
                  <span className="text-lg font-bold text-slate-900">
                    {lesson.title}
                  </span>
                  <span className="text-slate-700">{lesson.summary}</span>
                  <span className="mt-auto pt-2">
                    <SkillDots questionIds={lesson.questionIds} />
                  </span>
                </Link>
              </li>
            ))}
          </ol>
        )}
      </section>
    </main>
  );
}
