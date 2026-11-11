# CLAUDE.md: SuperDriver (repo: super-driver)

Handoff document for AI agents and anyone picking up this project. Read this fully before making changes.

@AGENTS.md

## Project overview

**SuperDriver** is an interactive driver's-ed learning platform for young people, built for 490 by a team of two: **Abdulrahman Elmi** and **Collins**. Users learn Washington State driving laws and Driver Guide content through short lessons, embedded checks, scenario puzzles and a timed practice knowledge test. The UI should feel like Khan Academy: clean, friendly, mastery-style progress. Build original visuals only; do not copy Khan Academy branding or assets. All wording should be toned down and user-friendly.

- **V1 (target: 2 days):** WA only, guest-only (no sign-in UI).
- **V2 (target: 2–3 more days):** state picker, Google sign-in, mini driving simulation.
- Development is AI-assisted, and work is split feature by feature between the two developers.

## Stack

| Layer | Choice |
|---|---|
| Frontend | Next.js (App Router), React, TypeScript |
| Backend / DB | Supabase (Postgres, RLS, Edge Functions) |
| Auth | Supabase Auth: anonymous sign-ins in V1; Google linking in V2 (no Clerk) |
| Guest progress | Supabase (source of truth) + localStorage pending-saves queue |
| Content | Supabase tables, seeded from SQL files in git |
| Local dev | Supabase CLI with Docker (both developers) |
| Animation | V1 scenarios: TBD (SVG-based options). V2 sim: Rive + canvas, to be decided later |
| Notifications | Email + GitHub issues for problem reports |

## Repository

- Name: `super-driver`
- Current branch: `main`, at the learning-slice squash merge (PR #9, `d7b4988`). `feat/learning-slice` and `docs/scenario-data-model` were squash-merged but still exist on GitHub (not deleted remotely yet; local copies are deleted). The scaffold branch was merged via PR #1 (as a merge commit, not a squash) and deleted locally and on the remote
- GitHub is set to squash-only merging (changed by Abdulrahman on 2026-11-07), so `main` keeps one commit per feature from now on
- Branching: one branch per big addition, `type/short-description` (Conventional Commit types), merged into `main` after review. `main` must always work.
- Commits: Conventional Commits; never commit without explicit user approval of the changes and the message.
- Secrets: never commit `.env*`. Use `.env.example` templates.

## Architecture decisions (detail)

### Content storage
- Content lives in Supabase tables: `lessons`, `sections`, `questions` (draft schema discussed; not yet finalized).
- Every content row has a `state` column (V1 check constraint allows only `'WA'`). V2 adds states as data, not code.
- IDs are stable text keys (e.g. `wa-right-of-way`) because progress references them. Never rename.
- Every row carries a `source` field pointing to the WA Driver Guide section it came from.
- The seed/migration SQL in git is the source of truth for content. Do not edit live content directly in the dashboard.
- TypeScript types are generated from the schema: `npx supabase gen types typescript`.
- Pages use static generation + ISR (`revalidate`) so content is served from cache.

### Content verification pipeline (write time, before users see anything)
- Status workflow: `draft` → `ai_reviewed` → `published`. Any edit returns an item to `draft`.
- RLS read policy exposes only `status = 'published'` rows, so the review gate cannot be skipped.
- The AI reviewer is given the official WA Driver Guide (PDF/text) and must return a verdict, an exact supporting quote, a page number, and suggested fixes. Results go in a `content_reviews` table.
- Code verifies that the cited quote actually appears in the guide's extracted text. Fabricated citations fail automatically.
- Each content row stores a hash of its content. The reviewer only runs when the current hash differs from the last reviewed hash, so the same content is never reviewed or paid for twice.
- A human approves before publishing.
- The reviewer runs server-side only (script or Edge Function). The AI API key never reaches the browser.

### Guest progress (V1)
- Every guest gets a Supabase anonymous user (real user ID, no email).
- Supabase is the source of truth for progress.
- localStorage is a pending-saves queue: write the update to localStorage, send it to Supabase, and remove it once confirmed. Retry leftovers on page load. Used when a save fails (network, Supabase unreachable, sign-in failure).
- Conflict rule: keep the best result per item. The same merge function will be reused for V2 account merging.
- Clearing browser data loses guest progress (session and queue both live in the browser). This is accepted for V1.
- Enable CAPTCHA (e.g. Cloudflare Turnstile) on anonymous sign-ins, and periodically clean up stale anonymous users.

### Problem reports
- A "report a problem" button is available in every phase (lessons, checks, scenarios, practice test).
- A `problem_reports` table records the content type and ID, phase, content hash at the time, user ID (anonymous allowed), and message. Users can insert only, never read others' reports.
- A database webhook on insert triggers an Edge Function, which sends an email and creates or updates a GitHub issue.
- Spam handling: one open GitHub issue per content item, with repeat reports added as comments; a per-user rate limit (e.g. 5 reports/hour); and email batching or deduping so the inbox is not flooded.
- GitHub access uses a fine-grained token scoped to this repo with Issues write only, stored as an Edge Function secret.
- Optional: auto-run the AI reviewer on reported items and attach its verdict to the notification.

### Practice test facts
- The WA knowledge test is 40 questions with an 80% passing score (32/40). This was verified on 2026-11-03 against a DOL score sheet and DOL-approved schools.
- Sources disagree on the time limit (35 vs 45 min), so store the timer as a config value.
- Random draw of 40 questions from the pool comes from a Postgres function called via `supabase.rpc`.

### Scenario puzzles (data model decided 2026-11-07, nothing built)
- A scenario is stored as **data**: a `jsonb` scene description (road layout, vehicles with positions and headings, signs, signals) drawn by one generic SVG component, so a new scenario is data, not a new component. The scene must be readable by the browser, because it draws the picture.
- The **solution is not part of the scene.** It lives in `choices` behind the same column privileges that hide `is_correct` (see "Hiding the correct answer"). It must never appear in a browser-readable column.
- Every scene carries a `schema_version`, a **required plain-language text description**, and a label on each vehicle and sign.
- **Bad data, in layers:** (1) validate shape and sanity at write time (required keys, known vehicle types, positions within bounds, no overlapping vehicles), failing CI instead of production; (2) a cheap database check that the scene is an object with a `schema_version` (whether `pg_jsonschema` is available is unverified); (3) a render-time error boundary that falls back to the text description so the learner can still answer; (4) the scene is part of the content hash, so an edit returns the item to `draft`.
- **Accessibility target beyond screen readers:** the text description, labelled entities, never color alone (shape, label or pattern), respect reduced-motion and do not rely on timing, keyboard-operable controls with large tap targets, zoom, contrast and plain language. WCAG 2.2 AA is the usual yardstick; the bar is Abdulrahman's to set.
- **Verification:** the AI reviewer checks the written explanation against the Driver Guide but cannot see the picture, so Abdulrahman checks the rendered scene next to its description before approving.

## V1 scope
- [ ] All WA Driver Guide content and driving laws as lessons (owner: Collins; 4 of the lessons are drafted and live, the rest are not started)
- [ ] Lessons with embedded checks ("check your understanding") (owner: Collins for the remaining content; the mechanism is built and live)
- [ ] Scenario puzzles (owner: Abdulrahman) (static or lightly animated intersections: right-of-way, four-way stops, school zones)
- [ ] Timed practice knowledge test (40 questions, 80% pass)
- [ ] Guest mode via anonymous sign-in, with the localStorage pending-saves queue
- [ ] Progress dashboard
- [ ] Content verification pipeline (AI review + human approval)
- [ ] Report-a-problem with email + GitHub issue notifications and spam protection (owner: Collins)

## V2 scope
- [ ] State picker (multi-state content)
- [ ] Google sign-in via identity linking (keeps the anonymous user ID and its progress)
- [ ] Account merge when the Google account already exists (best result per item)
- [ ] Gentle sign-in nudge after sustained use
- [ ] Mini top-down 2D driving simulation (Rive + canvas, TBD)

## Current state
**2026-11-10: the urgent demo is shipped and live.** PR #9 squash-merged the learning slice into `main` (`d7b4988`). It is deployed on Vercel at https://super-driver-seven.vercel.app, backed by the hosted Supabase project (ref `cppzijzrzqhwnekcomje`). The hosted project's URL and public (publishable) key are set as the two `NEXT_PUBLIC_SUPABASE_*` env vars on Vercel; they are public values, but keep them out of committed files. Never put the service-role or secret key anywhere in this repo or in the browser.

What is live: the four content tables with RLS, column grants and the `check_choice` grader (migration `20261108120000_learning_content.sql`); 4 WA lessons, 8 sections, 17 questions, 59 choices from the official Driver Guide (`supabase/seed.sql`), which Abdulrahman checked against the guide and published with `supabase/publish.sql` on 2026-11-09; the header with the "SuperDriver" wordmark and steering-wheel logo, a Khan-style home page with skill dots and a progress bar, lesson pages with graded checks, friendly error and 404 pages. Progress is localStorage only (demo shortcut).

Verified on the live site (2026-11-09): all routes, a full quiz run (0.2-0.5 s per check), wrong answer and retry, dropped network and Retry, a 375 px mobile view with no horizontal scroll; a scan of the 10 shipped JS files plus the HTML found no secrets, no JWTs, no database URL and no answer text. Verified against the hosted database as a visitor (and through `supabase-js` with the publishable key): published rows readable; `is_correct`, `explanation` and `status` refused; `select=*` on `choices` refused; insert, update and delete refused; the grader returns right, wrong and empty for an unknown id; `pg_graphql` is not enabled there. Not verified: Realtime, keyboard-only and screen-reader use, Safari/Firefox, a real phone.

**Known problem, fix decided but ON HOLD (Abdulrahman paused it on 2026-11-10):** all 17 correct answers are the first choice (confirmed against the live database), so always picking the first option scores 100%. Decided fix: (1) shuffle each question's choices once per page load in the browser (not again on "Try again"), with the choices hidden until the shuffle runs so they do not visibly jump; (2) reorder the choices in `seed.sql` so correct answers vary, with a positions-only patch SQL for the hosted database (re-running `seed.sql` on an existing database resets statuses to `draft` and can violate `unique (question_id, position)` when reordering, so use a patch, not a re-seed); (3) a guard against repeat clicks while an answer is being checked; (4) a taller tap target on the "← All lessons" link (18 px now). Until it ships, **new content must put the correct answer in varied positions** (see the Collins section).

NOT done: everything under "Temporary shortcuts and debt", the rest of the V1 scope.

Earlier state: planning complete and the scaffold merged into `main` (PR #1, merge commit `e5036e5`, 2026-11-07). Collins has been invited and has cloned the repo; he must pull the `.gitignore` fix.

Scaffold contents (verified 2026-11-05): Next.js 16.4.5 + React 19 + TypeScript + Tailwind v4, App Router, `src/` directory, import alias `@/*`, ESLint (`eslint-config-next`) + Prettier (`eslint-config-prettier` last in the ESLint config), Supabase CLI 3.0.0 as a dev dependency with `supabase/` initialized (`supabase init`; no migrations yet), `.env.example`, `AGENTS.md` (imported at the top of this file). `package-lock.json` is committed; fresh `npm ci` + `npm run build` + lint + `format:check` all pass.

Config notes:
- **npm** is the package manager. **Node 24**: `.nvmrc`, `engines` (`>=24 <25`) and `.npmrc` (`engine-strict=true`). A wrong Node fails with `EBADENGINE` (demonstrated).
- `create-next-app --yes` turned on `cacheComponents` and `partialPrefetching` by default; these were REMOVED from `next.config.ts` to keep classic caching. Do not re-add them without a decision.
- React Compiler is off.
- `.prettierignore` skips `CLAUDE.md` and `LOG.md` (Prettier would reformat tables and wrapping).
- Known, unresolved: `@types/node` is `^20` while the runtime is Node 24; `npm audit` reports 8 moderate issues, all `minimatch` inside the ESLint/typescript-eslint dev chain (the suggested `--force` fix downgrades `eslint-config-next`, so it was not applied).
- `db:types` writes to `src/lib/database.types.ts`, which does not exist until the schema does.

## Temporary shortcuts and debt (urgent demo build, 2026-11-08)
These were taken on purpose to ship a demo fast. Abdulrahman will verify the content himself for now, and we will come back to repay all of this. Do not treat any of it as the finished design.

| # | Shortcut | Decided design / what is missing | How to repay | Risk until then |
|---|---|---|---|---|
| 1 | **Content unreviewed**: 4 lessons drafted by an AI from the official guide, checked only by Abdulrahman | Write-time AI review with exact-quote citations, then human approval (see "Content verification pipeline") | Build the reviewer and `content_reviews`; re-verify every item; keep `publish.sql` as the human gate | Wrong or outdated driving law shown to learners. The footer tells them to check dol.wa.gov |
| 2 | **Progress in localStorage only** (`src/lib/progress.ts`) | Anonymous Supabase sign-in, progress table with RLS, localStorage as a pending-saves queue | Build sign-in + progress table; turn `progress.ts` into the queue; reuse its best-result merge | Progress is lost if browser data is cleared, and is per device. No server-side progress at all |
| 3 | **No content hash** on any content row | Hash per row so edits return it to `draft` and the reviewer never reruns on unchanged content | Add `content_hash` columns and the trigger or script | An edit to published content is not automatically unpublished |
| 4 | **`check_choice` has no rate limit and is an answer-key oracle** | Practice test must grade a whole submission at once and protect test questions | Design the test grader; add rate limiting if the lesson checks are abused | Someone can loop the function to learn every lesson answer (accepted for lessons) |
| 5 | **No CAPTCHA, no anonymous users** (sign-in not built) | CAPTCHA on anonymous sign-ins, stale-user cleanup | Part of the sign-in work | None yet, since there is no sign-in |
| 6 | **Hosted Supabase not verified**: default grants may differ from local; `pg_graphql` untested | Verify before launch (see "Hiding the correct answer") | After the hosted project exists, rerun the guard checks and a visitor REST test against it | Possible answer leak on the hosted project if its defaults differ. Must be checked at deploy time |
| 7 | **Seed on hosted is pasted into the SQL editor**, not a managed migration | Content seeding as a repeatable, reviewed pipeline | Decide a seeding approach (script or CI) | Manual steps can be skipped or done twice. The seed is idempotent, so a repeat is safe |
| 8 | **Light theme only, minimal accessibility testing** | WCAG 2.2 AA target (the bar is Abdulrahman's to set) | Add dark mode if wanted; audit contrast, keyboard use, screen reader, zoom | Not audited. Basics are in (labels, text status not color-only, focus outlines, reduced motion) |
| 9 | **Lesson pages render on request**, home page is ISR (60 s) | Static generation + ISR for all content pages | Add `generateStaticParams` and `revalidate` to lesson pages | Slightly slower lesson loads; no real risk |
| 10 | **No problem-report button yet** (Collins's feature) | Report-a-problem in every phase | Collins's slice; needs the content tables, which now exist | Learners cannot flag wrong content |
| 11 | **No automated tests for the app code** (only the database tests) | Component and end-to-end tests | Add a test runner and cover the quiz, progress store and error paths | App behavior was checked by hand in a browser; it can regress silently |
| 12 | **Mobile and other browsers untested** | Test on phones, Safari, Firefox | Manual pass, then automate | Layout or the timeout code (`AbortSignal.any`) may misbehave on older browsers |
| 13 | **Quiz answers lock after a correct answer** and there is no review mode, no practice test, no scenarios, no search, no accounts | Full V1 scope | Per the V1 scope list | The demo shows one feature only |

Updates to the table above: **#1** Abdulrahman checked the 4 lessons against the guide before publishing them on hosted (2026-11-09); there is still no AI review and no content hash, and everything Collins adds needs the same human check. **#4** demonstrated on the live site: all 59 choices were scanned through the grader in seconds, which is how the all-first-answers bug was confirmed. **#6** partly repaid: the hosted visitor checks pass (see "Current state"), `pg_graphql` is not enabled there, and the publishable key works with `supabase-js`; Realtime is still untested. New: **#14** no guard against repeat clicks on a quiz choice, and a late reply can overwrite a newer one (harmless because the check only reads); **#15** the "← All lessons" link is 18 px tall, under the 44 px touch guideline.

Also: the 2026-11-08 explanations were shortened by request. Abdulrahman wants the full-depth write-up of this build later ("make up the sped up time"): why each choice, the failure analysis, and the lessons. Owed items: a walkthrough of how RLS plus column grants interact on the four tables, why `questions.status` had to be granted, how retries stack, and `retry()` versus `reset()`.

## Collins: V1 content assignment (from 2026-11-10)
Abdulrahman assigned Collins two more V1 items, on top of report-a-problem: **(1) adding the WA Driver Guide to the project, and (2) finishing the lessons with embedded checks** (the rest of the guide as lessons, each section with "check your understanding" questions). The assignment was given in one sentence, so the details below are the agent's reading of it. Collins and Abdulrahman should confirm or correct them before large work starts.

**Reading of the assignment (confirm):**
- *Adding the guide* means getting the official guide text into the project in a form we can cite from: it is the source for lesson content and the text the AI reviewer will check against (quote and page number must be verifiable in code). Where it lives and in what format is an open decision (below), not Collins's to pick alone.
- *Finishing the lessons* means writing the remaining lessons, sections, questions and choices as seed content, following the rules below. The mechanism (tables, grader, lesson pages, quiz) already exists; this is mostly content, not new features.

**Get set up:** `git pull` on `main`, `nvm use`, `npm ci`, copy `.env.example` to `.env.local` and fill it from `npm run db:status` (local demo keys only), `npm run db:start`, `npm run db:reset` (loads `supabase/seed.sql` as drafts), then publish locally with `supabase/publish.sql` (command in "Commands") and run `npm run dev`. **Open http://localhost:3000, not the LAN address**, or the buttons will not work. Collins's machine has not been tested yet.

**Content rules (all of these matter):**
1. IDs are stable text keys such as `wa-...`, never renamed (progress will reference them).
2. Every section and question carries a `source` that points to the exact Driver Guide section. Use the official WA DOL guide only; do not copy from other sites.
3. New content is inserted as `draft`. A human checks it against the guide before `publish.sql` runs. There is still no AI review, so the human check is the only gate.
4. Every question has exactly one correct choice, and **every choice has an explanation**. `publish.sql` refuses a question without exactly one correct choice or with fewer than two choices.
5. **Do not put the correct answer first every time.** The first batch did, and it is a live bug (see "Current state"). Vary the position of the correct choice across questions.
6. Plain, friendly wording; questions must make sense on their own. Section `body` is plain text: a blank line starts a paragraph and lines beginning with `- ` are bullets. No HTML or Markdown; it is rendered as text.
7. Schema rules still hold: never grant table-wide `SELECT` on `choices`; any new table needs RLS and explicit column grants, and `npm run db:test` must pass (update the guard's allow-list only on purpose). The correct answer must never be readable from the browser.
8. Do not re-run `seed.sql` against the hosted database to change existing rows' order (see the answer-order note above); ask Abdulrahman for a patch.

**Process:** one branch per group of lessons (`feat/lessons-<topic>`), commit one logical change at a time, open a PR, and Abdulrahman reviews and squash-merges. Before a PR: `npm run lint`, `npm run format:check`, `npm run build`, `npm run db:test` all pass. Abdulrahman owns the hosted Supabase project and the Vercel project, so he applies seed and publish SQL to the hosted database (a manual step in the Supabase SQL editor) until we decide otherwise. Commit rules in the global instructions apply: single-line Conventional Commit messages, no trailers, and never commit without Abdulrahman's approval.

**Risks to watch:** Collins now owns two slices (report-a-problem plus content), so the content workload may squeeze the report-a-problem work; the reviewer pipeline (Abdulrahman) depends on how the guide text is stored, so that decision should come early; and content errors are the biggest risk to users, so the human check against the guide must not be skipped to save time.

## Local Supabase (verified 2026-11-07, Abdulrahman's machine)
- `npm run db:start` works with Docker 29.9.2 on macOS (Apple silicon). First run pulls ~12 images (a few minutes); later starts are fast. Postgres 17.11, 12 containers, all healthy.
- Ports: API 54321, DB 54322, Studio 54323, Mailpit 54324. `project_id` in `supabase/config.toml` is `SuperDriver`, so containers are named `supabase_*_SuperDriver` (use that name with `docker exec`).
- Keys and URLs come from `npm run db:status`. The local keys are the public demo values; copy them into `.env.local` (gitignored), never into committed files.
- The `no files matched pattern: supabase/seed.sql` warning is expected until we add a seed file.
- Data survives `db:stop` then `db:start` (a table created before the stop was still there after; stop takes a backup). Not tested: what wipes it besides `db:reset`.
- `status` on a stopped stack prints a JSON `StatusDbInspectError` (no such container). That means "not running", not a broken setup.
- Anonymous sign-ins: `enable_anonymous_sign_ins` is now `true` in `supabase/config.toml` (it was `false`; V1 guest mode needs it). Verified with a real `POST /auth/v1/signup`: the token has `role: authenticated`, `is_anonymous: true`. So a guest uses the `authenticated` role, and privileges granted to `authenticated` apply to guests. Not tested: the old `false` value's error, and CAPTCHA.
- Not reproduced: a port-conflict failure. Holding port 54322 with a dummy listener (loopback and all interfaces) did NOT stop `db:start` on macOS, so we do not know what that error looks like.
- Not yet tested: Collins's machine.

## Hiding the correct answer: option A, verified findings (2026-11-07)
Design (final): answers live in a separate `choices` table. The browser roles (`anon`, `authenticated`) get `SELECT` only on safe columns (`id`, `question_id`, `body`). `is_correct`, `explanation`, and `status` are not granted. RLS (published-only) controls rows; column privileges control columns; both are needed. Grading runs in a `SECURITY DEFINER` function with `set search_path = ''`.

Tested on throwaway tables (since dropped) against local Supabase, as a visitor (`anon` key) and as a guest (real anonymous JWT):
- **Baseline is unsafe:** a new table in `public` grants ALL privileges to `anon` and `authenticated` with RLS off. An anonymous visitor read every column and deleted a row.
- **Protected, all refused (42501):** `select=*`, selecting `is_correct`, filtering on it (`?is_correct=eq.true`), sorting by it, filtering on `explanation`, and all writes. Same via SQL as each role: whole-row reference, `to_jsonb(row)`, `WHERE`, `EXISTS`, aggregates, `JOIN`, `GROUP BY`, `ORDER BY`. A control query on safe columns worked each time.
- **No side channels found:** `pg_stats` shows restricted roles nothing; Realtime pushed only granted columns and sent no event for a draft row; a column added later is hidden by default; roles cannot create objects in `public`; an RLS policy that reads an ungranted column (`status`) works. `service_role` still reads everything (server only).
- **Detectable mistake:** the error hint says "GRANT SELECT ON table TO authenticated", which reopens the leak. A guard query over `information_schema.column_privileges` flagged it. It becomes an automated test with the real schema.
- **Secure-by-default (decided: change the defaults, plus a guard test; BUILT and verified locally):** migration `supabase/migrations/20261108050310_secure_default_privileges.sql` revokes the default table, sequence and function privileges from `anon`/`authenticated` for role `postgres`. For functions, a schema-scoped revoke is NOT enough because `PUBLIC` keeps EXECUTE; the global form (without `in schema`) is needed, and the migration has both. `service_role` and `postgres` keep access. It must stay the first migration.
- **Guard test:** `npm run db:test` runs `supabase/tests/database/security_defaults.test.sql` (pgTAP, 8 checks, runs in a rolled-back transaction). It failed 4 of 8 before the migration (a new table got 14 grants) and passed 8 of 8 after `db:reset`. Four deliberate mistakes were each caught by the right check (re-granted defaults, a table without RLS, a table-wide `SELECT` on `choices`, a function granted to `anon`), and the suite passed again after cleanup.
- **Checked side effects:** extension functions are owned by `supabase_admin`, so the `postgres`-scoped default does not change them (`anon` can still run them). A table created through Studio's own API (pg-meta) is owned by `postgres`, so it is covered, but it comes out with RLS off, which check 5 would catch. Not tested: Studio's UI buttons, and the `storage` schema (Supabase's own defaults there still grant `anon`/`authenticated`; we do not create objects there).

Rules that follow (the defaults and the guard test now enforce parts of these):
1. Every table: enable RLS, `REVOKE ALL` from `anon, authenticated`, then grant only the columns and operations needed.
2. Never grant table-wide `SELECT` on `choices`. Ignore the error hint. Keep `choices` out of the `supabase_realtime` publication.
3. Every function: `REVOKE EXECUTE ... FROM public, anon, authenticated`, then grant explicitly (new functions are executable by everyone by default, including `anon`).

Not verified, gaps:
- `pg_graphql` is not enabled locally, so GraphQL was not tested. Retest on the hosted project if it is enabled there.
- Realtime was tested only as a guest (`authenticated`), not as `anon`.
- Hosted Supabase may have different default grants than local. Verify there before launch.
- The public API root (`/rest/v1/`) lists table and column names (not values) to anyone, including `is_correct`.
- **Design constraint:** a per-choice check function is an answer-key oracle (a guest looped over the ids and learned the correct one). Fine for lesson checks; the practice test must grade the whole submission at once, and test questions need protection from per-choice checking. Not designed yet.

## Architecture docs
`architecture/` holds Mermaid diagrams of the system overview, key data flows, and the draft data model, plus `changes.md`, a dated log of architecture changes. Update it in the same commit/PR as any decision or code that changes data flow, mark things `built` or `planned`, and check the diagrams against the real code and schema. Start at `architecture/README.md`.

## Commands
- `npm ci`: install exactly what the lockfile says (use this after cloning). `nvm use` first.
- `npm run dev` / `build` / `start`: Next.js. **Open http://localhost:3000, not the machine's LAN IP.** On the LAN address `next dev` blocks its client, so the page renders but never hydrates (buttons do nothing, reproduced), and the app's `127.0.0.1` Supabase URL would not be reachable anyway. Needs `.env.local` (see `.env.example`; values from `npm run db:status`).
- Seed content: `npm run db:reset` loads `supabase/seed.sql` (drafts). To publish after checking the content: `docker exec -i supabase_db_SuperDriver psql -U postgres -v ON_ERROR_STOP=1 < supabase/publish.sql`.
- `npm run lint`, `npm run format`, `npm run format:check`.
- `npm run db:start` / `db:stop` / `db:status` / `db:reset` / `db:types`: Supabase CLI wrappers (need Docker running).
- `npm run db:test`: runs the pgTAP tests in `supabase/tests/database/`, including the security guard (needs the local stack running; the first run pulls the `pg_prove` image).

## Next steps
1. ~~Fix the `gitignore` → `.gitignore` filename~~ Done (`be607e4`).
2. ~~Add Collins to the GitHub repo~~ Done: invited and cloned.
3. ~~Decide the scaffold options~~ and ~~the feature split~~ Done (see Decisions log). Next: finalize the schema, since Collins's `problem_reports` table depends on the content tables.
4. ~~Branch `chore/scaffold-nextjs-supabase`~~ Merged (PR #1). Collins should pull `main`, `nvm use`, and run `npm ci`.
5. ~~Abdulrahman: Docker + local Supabase~~ Done and verified (see "Local Supabase"). Collins still needs to run `npm run db:start` on his machine.
6. ~~Branch `feat/v1-database-schema`~~ Content tables built and merged in PR #9 (section-owned questions; no `problem_reports` yet).
7. ~~Deploy the demo~~ Done 2026-11-09: PR #9 merged, live on Vercel with the hosted Supabase project, content checked and published, visitor checks run against the hosted database.
8. **Answer-order fix** (Abdulrahman; decided, on hold): shuffle once per page load, reorder the seed plus a hosted patch, double-click guard, bigger tap target (see "Current state").
9. **Collins: add the WA Driver Guide and finish the lessons with embedded checks** (see "Collins: V1 content assignment"). First step: Collins confirms the reading of the assignment and proposes where the guide text should live.
10. **Repay the debt** above, in an order Abdulrahman picks; each repayment is its own decision and branch.
11. Write the full-depth learning notes owed for this build (see the debt section).

## Open decisions
- Scaffold options (decided: npm, app at root, Node 24, Tailwind with shadcn/ui added on demand, ESLint + Prettier, Supabase CLI as a project dependency). All scaffold options are settled.
- Scenario puzzle rendering for V1 (plain SVG / SVG + CSS transitions / SVG + Motion).
- Grounding approach for the reviewer (send the whole PDF/chapter vs. chunked search stored in Supabase).
- How the practice test grades without letting per-choice checks reveal the answer key.
- How scenarios attach to questions (questions now belong to sections; a scenario is visual context for a question whose answer lives in `choices`), and how the human approval step shows a rendered scene (a small admin preview page is now likely, since JSON in the Supabase dashboard cannot be checked visually).
- The scenario rendering approach (plain SVG / SVG + CSS transitions / SVG + Motion) is still open and affects the renderer, not the stored format.
- How the human approval step is done (Supabase dashboard vs. a small admin page).
- Where the reviewer runs (local script vs. Edge Function) and which AI model/API.
- Where the WA Driver Guide text lives and in what format (a file in the repo, or a Supabase table; with page markers so the reviewer's quote and page number can be checked in code). This also settles the reviewer grounding decision above. Abdulrahman decides; Collins proposes options with tradeoffs first. Open questions to settle with it: whether the full guide may be stored in the repo, and how the text is extracted from the PDF.
- Who applies content to the hosted project (today only Abdulrahman can). Options include giving Collins access, or a repeatable seeding script or CI step (debt #7).
- Email provider.

## Decisions log
| Date | Decision | Reasoning |
|---|---|---|
| 2026-11-03 | Next.js frontend | Routing, static generation/ISR, large ecosystem, easy deploy |
| 2026-11-03 | Content in Supabase tables | Enforced integrity; natural fit for the test question pool, V2 progress, and the review/status workflow |
| 2026-11-03 | Supabase Auth instead of Clerk | One vendor; RLS can use `auth.uid()` directly |
| 2026-11-03 | Anonymous sign-ins for guests | Guest is a real DB user, so linking Google later keeps all progress |
| 2026-11-03 | localStorage as pending-saves queue only | Covers failed saves; Supabase stays the single source of truth |
| 2026-11-03 | Write-time AI review + human approval (not view-time) | Users only see verified, stable content; no per-view latency/cost; hash-based caching avoids repeat reviews |
| 2026-11-03 | Report-a-problem → email + GitHub issue, with spam protection | Feedback loop in every phase without flooding the inbox |
| 2026-11-03 | V1 guest-only; sign-in nudge + Google linking in V2 | A nudge needs a working sign-in, so both ship together |
| 2026-11-03 | Both devs run Supabase locally with Docker | Avoids shared-DB collisions and environment drift |
| 2026-11-03 | Feature-by-feature work split | Superseded on 2026-11-07 by the ownership row below. Original reasoning: both devs learn the full stack; requires an agreed shared contract first |
| 2026-11-07 | Ownership: V1 Collins = report-a-problem only; Abdulrahman = all other V1 features. V2 (tentative) Collins = sign-in nudge + mini driving simulation; Abdulrahman = state picker, Google sign-in, account merging | Report-a-problem is the most self-contained V1 slice (own table, Edge Function, email, GitHub), so merge conflicts are unlikely. Risks accepted: V1 is lopsided (9 of 10 items on Abdulrahman against a 2-day target); Collins's table depends on the content schema (type, ID, hash) and his button must be placed in Abdulrahman's pages, so he can build the Edge Function/email/GitHub parts against a stub table first; the V2 nudge needs working Google sign-in before it can be tested. **V1 part superseded on 2026-11-10 by the row below** |
| 2026-11-10 | Ownership update (V1): Collins also owns adding the WA Driver Guide and finishing the lessons with embedded checks, in addition to report-a-problem. Abdulrahman keeps scenarios, the practice test, progress and sign-in, the verification pipeline, the dashboard and the pending answer-order fix | Abdulrahman's call once the urgent demo had shipped: the content is the largest remaining V1 piece and can proceed in parallel with the engine work that depends on the schema. Reasoning inferred from context; Abdulrahman to confirm or edit. Risks: Collins now has two slices; the reviewer pipeline depends on where the guide text lives (open decision); content errors reach learners, so the human check against the guide cannot be skipped; the assignment was one sentence, so the scope reading in "Collins: V1 content assignment" needs confirming |
| 2026-11-03 | npm as package manager (over pnpm, bun) | Ships with Node and is the default in Next.js/Supabase docs, so nothing extra for Collins to install; pnpm/bun gains are marginal for a 2-person, ~5-day project. Commit `package-lock.json`, use `npm ci` for installs, and pin Node so both devs match |
| 2026-11-03 | Next.js app at the repo root (not `web/`) | One `package.json`; Vercel/CI/`create-next-app` default to root; `supabase/` already gives the backend its own directory. Caveat: Next config files share the root. Check `create-next-app` doesn't overwrite our `.gitignore` |
| 2026-11-03 | Tailwind first; shadcn/ui added component by component (over CSS Modules, or shadcn from day one) | Abdulrahman is learning, so plain Tailwind first, then shadcn/Radix for accessible pieces (dialogs, progress, radio groups). Components are copied into `components/ui/`, so we own them. Only one dev adds a given component at a time to avoid merge conflicts. Verify current Tailwind v4 / shadcn init steps against official docs at scaffold time |
| 2026-11-05 | ESLint + Prettier (over Biome, or Biome mixed in) | Standard `create-next-app` setup with `eslint-config-next` framework rules; Biome lacks those rules, and two formatters would fight. Use `eslint-config-prettier`, commit `.prettierrc`, add `lint` and `format:check` scripts (and later run them in CI) |
| 2026-11-05 | Supabase CLI as a project dependency (over global install) | Version pinned in the lockfile so both devs get identical local-stack, migration and type-gen behavior; fresh clone needs only `npm ci` + Docker. Wrap long `npx supabase` commands in `npm run` scripts (`db:start`, `db:types`, ...) |
| 2026-11-05 | Code under `src/` | Keeps the repo root to config files plus `supabase/`; separates app code from the backend folder |
| 2026-11-05 | React Compiler off | Abdulrahman is learning React; manual memoization shows when and why components re-render. Can be turned on later |
| 2026-11-05 | Classic caching (Cache Components off) | Matches the static generation + ISR plan; far more documentation. `create-next-app --yes` enabled it by default, so it was removed from `next.config.ts` |
| 2026-11-05 | Include `AGENTS.md`, imported from `CLAUDE.md` with `@AGENTS.md` | Next.js's agent guidance stays in its own file; project rules stay in `CLAUDE.md` |
| 2026-11-07 | Answer choices in a separate `choices` table (over a `jsonb` column on `questions`) | Integrity matters, and the correct answer must not be visible in the browser's network tab. A `jsonb` column cannot hide one field, since the flag sits inside the JSON the client reads. A table allows column-level privileges and database-enforced rules. Costs: a join on every question read, and the content hash and the published-only RLS policy must cover two tables |
| 2026-11-07 | Hide answers with option A: `is_correct` and `explanation` on `choices`, browser roles get column-level `SELECT` on safe columns only, graded by a `SECURITY DEFINER` function (over a separate answer-key table, or a view without the flag) | One table, and the database itself refuses the hidden columns. Verified against local Supabase (REST, SQL, Realtime; see "Hiding the correct answer"). Costs: `select *` fails from the browser so queries must list columns; a teammate granting table-wide `SELECT` reopens the leak (guard test needed); at-least-one-correct needs a trigger or publish-time check |
| 2026-11-07 | Secure-by-default privileges: change the defaults in the first migration, plus an automated guard test (over per-migration revokes, or revokes with a guard only) | A forgotten grant fails closed as "permission denied" instead of silently exposing a table, and a guard test catches deliberate over-granting that defaults cannot. Costs: every table needs explicit grants (including `problem_reports`); defaults are per creating role (only `postgres` is covered, which owns migration-created and Studio-API-created tables); hosted parity is unverified |
| 2026-11-07 | Scenario puzzles stored as a `jsonb` scene description drawn by one generic SVG renderer (over template plus parameters, pre-drawn images, or fully relational scene tables), with layered bad-data handling, broader accessibility, and human visual verification | Scenarios become data, not code, so content can grow without new components, and animation stays possible. Costs: the generic renderer must be built before the first scenario works; invalid scenes need validation and a safe fallback; the AI reviewer cannot see pictures, so a human checks the rendering (likely needing an admin preview page); the solution must stay out of the browser-readable scene |
| 2026-11-03 | Pin Node 24 (over 22) | Current LTS and what Abdulrahman already runs; Next.js needs >=20.9. Enforced with `.nvmrc`, `engines`, and `engine-strict=true` so a wrong Node fails at install |
| 2026-11-08 | Urgent special case: compress explanations and ship a working, deployed learning demo, then go back and repay | Abdulrahman's deadline. Decisions still need his approval; shortcuts are tracked in "Temporary shortcuts and debt" so they are repaid, not forgotten |
| 2026-11-08 | Questions belong to a section (`questions.section_id`), over a join table or a purpose flag | Lesson checks live inside sections, so this is the simplest fit. Costs: the practice test must query across sections or the schema changes; a question lives in one place |
| 2026-11-08 | Progress in localStorage only for the demo (over none, or anonymous sign-in + Supabase) | Fastest working persistence. Costs: not the decided architecture, lost when browser data is cleared, per device. Debt #2 |
| 2026-11-08 | Deploy on Vercel with hosted Supabase (over Netlify, Cloudflare) | Most direct Next.js path and documentation. Hosted default grants must be verified (debt #6) |
| 2026-11-08 | Four lessons in the demo (over two, or one polished), content verified by Abdulrahman only | Fuller learning path. The riskiest option because correctness matters and there is no AI review yet. Drafted from the official guide text with section citations; seeded as `draft`, published by `publish.sql` after a human check. Debt #1 |
| 2026-11-08 | Lesson checks graded by `check_choice` (`SECURITY DEFINER`, returns right/wrong plus explanation), allow-listed in the guard test | Keeps `is_correct` out of the browser. It is an oracle if looped; accepted for lessons, never for the practice test. Debt #4 |
| 2026-11-08 | Visual style resembles Khan Academy's feel (white header, navy hero, indigo actions, rounded cards, mastery-style skill dots) but with original artwork, logo, wording and driving-specific content | Abdulrahman's request: resemble, not copy; no Khan branding or assets |
| 2026-11-08 | Turn off supabase-js's own read retries (`db: { retry: false }`) and keep one retry layer of ours with an 8 s timeout | Measured: its 4 attempts stacked with ours made a stalled database take about 78 s to fail; now about 16 s |
| 2026-11-08 | Error page uses `retry()` (refetch), not `reset()` | Tested: `reset()` kept showing the failure after the database recovered |
| 2026-11-08 | Grant `questions.status` to the browser roles (the only `status` column granted) | The `choices` read policy reads it, and a policy that reads another table is checked against the caller's column privileges. Found by a failing test. It always reads `published` for a visitor |

## Progress log
- 2026-11-03: Planning session completed. Stack, content storage, auth, verification and reporting decided. Repo initialized with docs and `.gitignore`.
- 2026-11-03: Created the GitHub repo and pushed the first commit (`docs: initialize repo with project plan, build log, and gitignore`). Platform renamed from SuperDrive to SuperDriver; docs updated to match (repo name stays `super-driver`). Spotted that the ignore file was committed as `gitignore` without the dot.
- 2026-11-03: Fixed the ignore file name (`be607e4`). Collins invited and cloned the repo. Chose npm as the package manager, app at the repo root, and Node 24. Added `.nvmrc` and `.npmrc`.
- 2026-11-05: Settled the remaining scaffold options (Tailwind first with shadcn/ui on demand, ESLint + Prettier, Supabase CLI as a dependency, `src/`, React Compiler off, classic caching, `AGENTS.md`). Built the scaffold on `chore/scaffold-nextjs-supabase` (generated in a temp dir, then copied in so our `.gitignore` was not overwritten). First install hit an npm registry 404 for `electron-to-chromium@1.5.478` (published seconds earlier; resolved within minutes, no workaround needed). Verified: fresh `npm ci`, build, lint, `format:check`, `EBADENGINE` on a wrong Node. Committed as five commits; pushed `main` (ignore-file fix) and the branch. Note: `npm ci` leaves a ~600 MB gitignored `node_modules/` and never edits the lockfile.
- 2026-11-07: Started local Supabase for the first time (`npm run db:start`) and verified Postgres, REST, container health, and data persistence across stop/start. Found `enable_anonymous_sign_ins = false` in `config.toml` (must be enabled for guest mode). Could not reproduce a port-conflict failure on macOS. Abdulrahman set the GitHub repo to squash-only merging after PR #1 landed as a merge commit by accident.
- 2026-11-07: PR #1 reviewed and merged by Abdulrahman. It landed as a merge commit instead of a squash, so `main` has the six branch commits plus the merge commit. Left as is (no history rewrite). Local branch deleted with `git branch -D`; remote branch already deleted by GitHub.
- 2026-11-07: Added the `architecture/` folder (overview, five flows, draft data model, change log) after Abdulrahman added a global rule requiring one in every project. Diagrams checked with a real Mermaid renderer (6 of 6 render; a deliberately broken one is rejected). Only the dev environment is marked built. Also: Abdulrahman rejected `jsonb` for answer choices because integrity matters and the correct answer must not be visible in the browser, and leans to a separate `choices` table; the second, final decision and how the answer is hidden are still pending.
- 2026-11-07: Finalized the answer-hiding design (option A) after Abdulrahman confirmed the separate `choices` table. Turned on anonymous sign-ins in `supabase/config.toml` and verified a guest token has role `authenticated`. Tested option A on throwaway tables against local Supabase (REST as visitor and guest, SQL as each role, `pg_stats`, a Realtime WebSocket): no leak found. Found that new public tables grant everything to the browser roles by default, that new functions are executable by `PUBLIC`, and that a per-choice check function is an answer-key oracle. Not verified: GraphQL (extension off locally), hosted Supabase defaults. Scratch tables dropped. Committed and merged via PR #6. The app was quit mid-edit once; the docs were redone from a clean state.
- 2026-11-07: Built secure-by-default privileges (first migration `20261108050310_secure_default_privileges.sql`) and the pgTAP guard test (`npm run db:test`), as decided (change the defaults, plus a guard test). Test-first: the guard failed 4 of 8 before the migration and passed 8 of 8 after `db:reset`; four deliberate mistakes (re-granted defaults, no RLS, table-wide SELECT on `choices`, function granted to `anon`) were each caught by the right check. Also checked that extensions are unaffected and that tables made through Studio's API are owned by `postgres` (covered). Added architecture section 7 (access-control layers). Not verified: hosted Supabase, GraphQL, Studio UI buttons. Committed on `feat/secure-default-privileges` (PR #6 had already squash-merged the earlier config and findings commits, so these three were moved to a fresh branch from `main`).
- 2026-11-07: Decided the scenario data model: option A, a `jsonb` scene description drawn by one generic SVG renderer, with layered bad-data handling, accessibility beyond screen readers, and a human visual check. Recorded the consequence that approval likely needs a rendered preview page, and that the solution stays in `choices`. Nothing built yet. The rendering approach (SVG / CSS / Motion) and how scenarios attach to questions are still open.
- 2026-11-08: Urgent demo build on `feat/learning-slice` after Abdulrahman asked for a deployed full-stack learning feature with shorter explanations and a debt-repayment pass afterwards. He chose: section-owned questions, localStorage-only progress, Vercel, four lessons. Built the four content tables, RLS, column grants and `check_choice` (migration `20261108120000_learning_content.sql`), the 22-check pgTAP suite, seed content drafted from the real Driver Guide text (fetched from dol.wa.gov, cited per section) with `publish.sql` as the human gate, typed Supabase client, header with a steering-wheel logo, a Khan-style home page, lesson pages with graded checks, and error and 404 pages. Committed as separate commits as he asked. Testing found and fixed: `choices` policy needed `questions.status` granted; stacked retries made a frozen database take over a minute (library retry now off, about 16 s); the error page's `reset()` did not recover (now `retry()`); Mermaid diagram 9 had a semicolon in a Note. Abdulrahman hit "buttons do nothing": reproduced as a LAN-IP-versus-localhost dev-server issue (page not hydrated), documented in Commands. Not done: deploy, content verification, PR. The debt is in "Temporary shortcuts and debt".
- 2026-11-10: The urgent demo shipped: PR #9 (squash) merged the learning slice into `main` and Abdulrahman deployed it to Vercel (https://super-driver-seven.vercel.app) with a hosted Supabase project. Testing it live found one real problem (all 17 correct answers are the first choice) plus a few small ones; Abdulrahman chose a browser shuffle plus a seed-order fix, agreed to shuffle once per page load and the extras, then put the fix on hold. He then assigned Collins the WA Driver Guide and the remaining lessons with embedded checks. This update (state, the new Collins section, open decisions, decisions log) was pushed directly to `main` at his explicit request, instead of through a branch and PR.
