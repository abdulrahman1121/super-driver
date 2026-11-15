import Link from "next/link";
import { notFound } from "next/navigation";
import { Quiz } from "@/components/Quiz";
import { SectionBody } from "@/components/SectionBody";
import { SkillDots } from "@/components/SkillProgress";
import { getLesson, getLessons } from "@/lib/content";

export default async function LessonPage({
  params,
}: PageProps<"/lessons/[id]">) {
  const { id } = await params;
  const [lesson, lessons] = await Promise.all([getLesson(id), getLessons()]);
  // An unknown or unpublished lesson is a normal 404, not an error.
  if (!lesson) notFound();

  const index = lessons.findIndex((l) => l.id === lesson.id);
  const next = index >= 0 ? lessons[index + 1] : undefined;
  const questionIds = lesson.sections.flatMap((s) =>
    s.questions.map((q) => q.id),
  );

  return (
    <main className="mx-auto max-w-3xl px-4 py-8">
      <nav aria-label="Breadcrumb" className="text-sm">
        <Link
          href="/#lessons"
          className="inline-flex min-h-11 items-center font-semibold text-indigo-800 hover:underline"
        >
          ← All lessons
        </Link>
      </nav>

      <header className="mt-4 rounded-2xl bg-indigo-950 p-6 text-white sm:p-8">
        <p className="text-sm font-semibold tracking-wide text-indigo-200 uppercase">
          Lesson {lesson.position}
        </p>
        <h1 className="mt-1 text-3xl font-bold tracking-tight">
          {lesson.title}
        </h1>
        <p className="mt-2 text-lg text-indigo-100">{lesson.summary}</p>
        <div className="mt-5 rounded-xl bg-white p-4">
          <SkillDots questionIds={questionIds} />
        </div>
      </header>

      {lesson.sections.map((section) => (
        <section key={section.id} className="mt-10">
          <h2 className="text-2xl font-bold text-slate-900">{section.title}</h2>
          <div className="mt-4">
            <SectionBody body={section.body} />
          </div>
          <p className="mt-3 text-sm text-slate-600">
            Source: {section.source}
          </p>

          {section.questions.length > 0 && (
            <>
              <h3 className="mt-8 text-lg font-bold text-slate-900">
                Check your understanding
              </h3>
              <Quiz questions={section.questions} />
            </>
          )}
        </section>
      ))}

      <div className="mt-12 flex justify-end border-t border-slate-200 pt-6">
        {next ? (
          <Link
            href={`/lessons/${next.id}`}
            className="rounded-lg bg-indigo-600 px-6 py-3 font-semibold text-white hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-700"
          >
            Next: {next.title} →
          </Link>
        ) : (
          <Link
            href="/#lessons"
            className="rounded-lg bg-indigo-600 px-6 py-3 font-semibold text-white hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-700"
          >
            Back to all lessons
          </Link>
        )}
      </div>
    </main>
  );
}
