# Architecture changes

Newest first. Each entry says what changed, why, and where the decision is recorded.

## 2026-11-07: Architecture folder created

- Added `architecture/` with the overview, user flows, and a draft data model.
- Why: a standing project rule is to keep a visual, incrementally updated picture of data flow.
- State at this date: only the dev environment is **built** (Next.js app on the stock starter page, local Supabase in Docker, not connected to each other). Everything else is **planned** from the 2026-11-03 decisions.

## 2026-11-07: Answer choices become their own table

- Choices for a question live in a separate `choices` table instead of a `jsonb` column on `questions`. Status: decided (still **planned**, not built).
- Why: integrity matters, and the correct answer must not be readable in the browser's network tab. A `jsonb` column cannot hide one field inside it.
- How the answer is hidden is a **pending decision**: option A (`is_correct` on `choices`, column-level privileges, graded by a server-side function) is chosen but not yet confirmed as final. See the practice test flow in `data-flow.md`.
- Decisions log: see the 2026-11-07 `choices` row in `CLAUDE.md`.

## 2026-11-05: Scaffold and local Supabase

- Next.js app at the repo root with `src/`, Tailwind, ESLint + Prettier; Supabase CLI as a project dependency; `supabase/` initialized. Local stack verified on 2026-11-07.
- Decisions log: see the 2026-11-03 and 2026-11-05 rows in `CLAUDE.md`.

## 2026-11-03: Initial architecture decided (planned)

- Content in Supabase tables with a `draft` → `ai_reviewed` → `published` workflow, anonymous guest sign-ins, localStorage as a pending-saves queue, and report-a-problem via webhook, email, and GitHub issues.
- Decisions log: see the 2026-11-03 rows in `CLAUDE.md`.
