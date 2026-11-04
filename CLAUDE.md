# CLAUDE.md: SuperDrive (repo: super-driver)

Handoff document for AI agents and anyone picking up this project. Read this fully before making changes.

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
- Current branch: `main` (initial setup; no code yet)
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

## V1 scope
- [ ] All WA Driver Guide content and driving laws as lessons
- [ ] Lessons with embedded checks ("check your understanding")
- [ ] Scenario puzzles (static or lightly animated intersections: right-of-way, four-way stops, school zones)
- [ ] Timed practice knowledge test (40 questions, 80% pass)
- [ ] Guest mode via anonymous sign-in, with the localStorage pending-saves queue
- [ ] Progress dashboard
- [ ] Content verification pipeline (AI review + human approval)
- [ ] Report-a-problem with email + GitHub issue notifications and spam protection

## V2 scope
- [ ] State picker (multi-state content)
- [ ] Google sign-in via identity linking (keeps the anonymous user ID and its progress)
- [ ] Account merge when the Google account already exists (best result per item)
- [ ] Gentle sign-in nudge after sustained use
- [ ] Mini top-down 2D driving simulation (Rive + canvas, TBD)

## Current state
Planning complete. Repo initialized locally with `.gitignore`, `CLAUDE.md`, `LOG.md`. No application code yet.

## Next steps
1. Create the GitHub repo `super-driver`, push the initial commit, and add both developers.
2. Decide the feature split between Abdulrahman and Collins.
3. Branch `chore/scaffold-nextjs-supabase`: Next.js + TypeScript app, Supabase CLI init, `.env.example`.
4. Branch `feat/v1-database-schema`: finalize the content, review, progress, and report tables + RLS (this is the shared contract; both devs agree before parallel work).
5. Open decisions to resolve (see below).

## Open decisions
- Feature split between the two developers.
- Scenario puzzle rendering for V1 (plain SVG / SVG + CSS transitions / SVG + Motion).
- Grounding approach for the reviewer (send the whole PDF/chapter vs. chunked search stored in Supabase).
- `choices` as `jsonb` vs. a separate `choices` table.
- Scenario data model.
- How the human approval step is done (Supabase dashboard vs. a small admin page).
- Where the reviewer runs (local script vs. Edge Function) and which AI model/API.
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
| 2026-11-03 | Feature-by-feature work split | Both devs learn the full stack; requires an agreed shared contract first |

## Progress log
- 2026-11-03: Planning session completed. Stack, content storage, auth, verification and reporting decided. Repo initialized with docs and `.gitignore`.
