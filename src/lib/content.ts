import { createSupabase } from "@/lib/supabase";

// Server-side reads of published learning content. Only safe columns are
// selected: the database refuses `select *` on choices (is_correct and
// explanation are not readable by the browser roles), so every query lists its
// columns on purpose.

export type Choice = { id: string; position: number; body: string };
export type Question = {
  id: string;
  position: number;
  prompt: string;
  choices: Choice[];
};
export type Section = {
  id: string;
  position: number;
  title: string;
  body: string;
  source: string;
  questions: Question[];
};
export type LessonSummary = {
  id: string;
  position: number;
  title: string;
  summary: string;
  questionIds: string[];
};
export type Lesson = {
  id: string;
  position: number;
  title: string;
  summary: string;
  source: string;
  sections: Section[];
};

export class ContentError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "ContentError";
  }
}

const byPosition = <T extends { position: number }>(a: T, b: T) =>
  a.position - b.position;

// Reads can fail for transient reasons (network blip, cold start, timeout), so
// try twice before giving up. These are idempotent GETs, so a retry cannot
// create duplicates.
async function withRetry<T>(
  run: () => PromiseLike<{ data: T; error: { message: string } | null }>,
) {
  let lastMessage = "unknown error";
  for (let attempt = 0; attempt < 2; attempt++) {
    try {
      const { data, error } = await run();
      if (!error) return data;
      lastMessage = error.message;
    } catch (e) {
      lastMessage = e instanceof Error ? e.message : String(e);
    }
  }
  throw new ContentError(`Could not load lessons (${lastMessage})`);
}

export async function getLessons(): Promise<LessonSummary[]> {
  const supabase = createSupabase();
  const data = await withRetry(() =>
    supabase
      .from("lessons")
      .select("id, position, title, summary, sections(questions(id))")
      .order("position"),
  );
  return (data ?? []).map((l) => ({
    id: l.id,
    position: l.position,
    title: l.title,
    summary: l.summary,
    questionIds: l.sections.flatMap((s) => s.questions.map((q) => q.id)),
  }));
}

// Returns null when the lesson does not exist (or is not published), so the
// page can show a proper 404 instead of an error.
export async function getLesson(id: string): Promise<Lesson | null> {
  const supabase = createSupabase();
  const data = await withRetry(() =>
    supabase
      .from("lessons")
      .select(
        "id, position, title, summary, source, sections(id, position, title, body, source, questions(id, position, prompt, choices(id, position, body)))",
      )
      .eq("id", id)
      .maybeSingle(),
  );
  if (!data) return null;
  return {
    ...data,
    sections: data.sections.sort(byPosition).map((s) => ({
      ...s,
      questions: s.questions.sort(byPosition).map((q) => ({
        ...q,
        choices: q.choices.sort(byPosition),
      })),
    })),
  };
}
