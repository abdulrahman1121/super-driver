# Architecture changes

Newest first. Each entry says what changed, why, and where the decision is recorded.

## 2026-11-11: Content split into per-lesson files with a scoped publish step (planned)

- Each lesson group will live in its own SQL file in `supabase/content/` (for example `wa-traffic-signs.sql`) instead of one growing `supabase/seed.sql`, and publishing will be limited to the lessons named instead of every row.
- Why: `supabase/publish.sql` publishes every row, so publishing one checked lesson would publish every unchecked draft with it; pasting all of `seed.sql` into the hosted SQL editor sets live rows back to `draft`; and one shared file makes every lessons PR collide.
- Not built: how `db:reset` loads the files (`[db.seed] sql_paths` in `supabase/config.toml` already accepts a list and glob patterns), how the scoped publish receives lesson IDs, and whether the four live lessons move out of `seed.sql`. See section 3 of `data-flow.md`.
- Decided the same day, content only (no data-flow change): the lesson scope, all driving content plus one short license lesson.
- Decisions log: see the 2026-11-11 rows in `CLAUDE.md`.

## 2026-11-08: Learning slice built: lessons, graded checks, localStorage progress (built)

- Four content tables (`lessons`, `sections`, `questions`, `choices`) with RLS (published rows only) and column grants (the browser cannot read `is_correct`, `explanation` or `status`, except `questions.status`). `check_choice` is a `SECURITY DEFINER` function that grades one choice and returns right or wrong plus the explanation. Questions belong to a section (decided option A). Migration `20261108120000_learning_content.sql`.
- Next.js pages read published content on the server through a typed Supabase client with an 8 second timeout and one retry. The browser calls `check_choice` directly. Progress is stored in localStorage only (best result per question).
- Content is four unreviewed WA lessons (17 questions) seeded as drafts; `supabase/publish.sql` is the human publish gate.
- Why: an urgent demo of the learning feature on a working full-stack site. Several parts are deliberate shortcuts, listed under "Temporary shortcuts and debt" in `CLAUDE.md`: localStorage-only progress, no AI review, no content hash, no rate limit on `check_choice`.
- Found by testing, not by design: a policy that reads another table is checked against the caller's column privileges (so `questions.status` is granted); supabase-js retries stacked with ours made failures take over a minute; the error page needed `retry()`, not `reset()`.
- Decisions log: see the 2026-11-08 rows in `CLAUDE.md`. Diagrams: sections 1, 3, 6, 7 updated and section 9 added in `data-flow.md`.

## 2026-11-07: Scenario puzzles stored as a scene description (planned)

- A scenario is a `jsonb` scene description (road layout, vehicles, signs, signals) drawn by one generic SVG renderer. The solution is kept out of the scene and lives in `choices`, behind the column privileges that hide `is_correct`.
- Every scene has a `schema_version`, a required text description, and labels on each vehicle and sign. Bad data is handled in layers: write-time validation, a basic database check, a render-time fallback to the text description, and re-approval after any edit.
- Why: scenarios become data, not code, so content can grow without new components, and accessibility and validation rules live in one place.
- Not built: nothing exists yet. See section 8 of `data-flow.md`. Open: how scenarios attach to questions, and the rendering approach.
- Decisions log: see the 2026-11-07 scenario row in `CLAUDE.md`.

## 2026-11-07: Browser roles locked out of new objects by default (built)

- First migration (`20261108050310_secure_default_privileges.sql`): new tables, sequences and functions in `public` grant nothing to `anon` or `authenticated`. Plus a pgTAP guard test (`npm run db:test`) that fails if a table lacks RLS, an answer column is readable by the browser, or a function is callable without being allow-listed.
- Why: Supabase's defaults grant the browser roles everything on new tables, so an anonymous visitor could read and delete rows. A forgotten grant should fail closed.
- Verified: the guard failed 4 of 8 checks before the migration and passed after it; four deliberate mistakes were each caught. See section 7 of `data-flow.md`.
- Decisions log: see the 2026-11-07 secure-by-default row in `CLAUDE.md`.

## 2026-11-07: Architecture folder created

- Added `architecture/` with the overview, user flows, and a draft data model.
- Why: a standing project rule is to keep a visual, incrementally updated picture of data flow.
- State at this date: only the dev environment is **built** (Next.js app on the stock starter page, local Supabase in Docker, not connected to each other). Everything else is **planned** from the 2026-11-03 decisions.

## 2026-11-07: Answer choices become their own table

- Choices for a question live in a separate `choices` table instead of a `jsonb` column on `questions`. Status: decided (still **planned**, not built).
- Why: integrity matters, and the correct answer must not be readable in the browser's network tab. A `jsonb` column cannot hide one field inside it.
- How the answer is hidden: decided (option A, still **planned**): `is_correct` and `explanation` live on `choices`, the browser roles can only select safe columns, and a server-side function grades. It was tested on throwaway tables against local Supabase on 2026-11-07, and no leak was found through REST, SQL, `pg_stats` or Realtime. See the practice test flow in `data-flow.md` and the findings in `CLAUDE.md`.
- Also changed that day: `enable_anonymous_sign_ins` is now `true` in `supabase/config.toml`, so guest sign-in works locally (**built**, verified with a real sign-in).
- Decisions log: see the 2026-11-07 `choices` row in `CLAUDE.md`.

## 2026-11-05: Scaffold and local Supabase

- Next.js app at the repo root with `src/`, Tailwind, ESLint + Prettier; Supabase CLI as a project dependency; `supabase/` initialized. Local stack verified on 2026-11-07.
- Decisions log: see the 2026-11-03 and 2026-11-05 rows in `CLAUDE.md`.

## 2026-11-03: Initial architecture decided (planned)

- Content in Supabase tables with a `draft` → `ai_reviewed` → `published` workflow, anonymous guest sign-ins, localStorage as a pending-saves queue, and report-a-problem via webhook, email, and GitHub issues.
- Decisions log: see the 2026-11-03 rows in `CLAUDE.md`.
