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
- Current branch: `chore/scaffold-nextjs-supabase` (scaffold in progress, not yet committed or merged); `main` holds docs only
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
Planning complete and the scaffold exists on branch `chore/scaffold-nextjs-supabase`, **not yet committed**. `main` has the docs (`762ef1d`) plus the ignore-file fix (`be607e4`, local only: not pushed yet). Collins has been invited and has cloned the repo; he must pull the `.gitignore` fix.

Scaffold contents (verified 2026-11-05): Next.js 16.4.5 + React 19 + TypeScript + Tailwind v4, App Router, `src/` directory, import alias `@/*`, ESLint (`eslint-config-next`) + Prettier (`eslint-config-prettier` last in the ESLint config), Supabase CLI 3.0.0 as a dev dependency with `supabase/` initialized (`supabase init`; no migrations yet), `.env.example`, `AGENTS.md` (imported at the top of this file). `package-lock.json` is committed-to-be; fresh `npm ci` + `npm run build` + lint + `format:check` all pass.

Config notes:
- **npm** is the package manager. **Node 24**: `.nvmrc`, `engines` (`>=24 <25`) and `.npmrc` (`engine-strict=true`). A wrong Node fails with `EBADENGINE` (demonstrated).
- `create-next-app --yes` turned on `cacheComponents` and `partialPrefetching` by default; these were REMOVED from `next.config.ts` to keep classic caching. Do not re-add them without a decision.
- React Compiler is off.
- `.prettierignore` skips `CLAUDE.md` and `LOG.md` (Prettier would reformat tables and wrapping).
- Known, unresolved: `@types/node` is `^20` while the runtime is Node 24; `npm audit` reports 8 moderate issues, all `minimatch` inside the ESLint/typescript-eslint dev chain (the suggested `--force` fix downgrades `eslint-config-next`, so it was not applied).
- Not yet done: Docker + `npm run db:start` has not been run; `db:types` writes to `src/lib/database.types.ts`, which does not exist until the schema does.

## Commands
- `npm ci`: install exactly what the lockfile says (use this after cloning). `nvm use` first.
- `npm run dev` / `build` / `start`: Next.js.
- `npm run lint`, `npm run format`, `npm run format:check`.
- `npm run db:start` / `db:stop` / `db:status` / `db:reset` / `db:types`: Supabase CLI wrappers (need Docker running).

## Next steps
1. ~~Fix the `gitignore` → `.gitignore` filename~~ Done (`be607e4`).
2. ~~Add Collins to the GitHub repo~~ Done: invited and cloned.
3. ~~Decide the scaffold options~~ Done. Still to decide: the feature split between Abdulrahman and Collins.
4. Branch `chore/scaffold-nextjs-supabase`: scaffold built and verified; needs the user's approval to commit (split into logical commits), push, and open a PR (squash merge).
5. Both developers set up Docker and run Supabase locally (`npm run db:start`).
6. Branch `feat/v1-database-schema`: finalize the content, review, progress, and report tables + RLS (this is the shared contract; both devs agree before parallel work).

## Open decisions
- Scaffold options (decided: npm, app at root, Node 24, Tailwind with shadcn/ui added on demand, ESLint + Prettier, Supabase CLI as a project dependency). All scaffold options are settled.
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
| 2026-11-03 | npm as package manager (over pnpm, bun) | Ships with Node and is the default in Next.js/Supabase docs, so nothing extra for Collins to install; pnpm/bun gains are marginal for a 2-person, ~5-day project. Commit `package-lock.json`, use `npm ci` for installs, and pin Node so both devs match |
| 2026-11-03 | Next.js app at the repo root (not `web/`) | One `package.json`; Vercel/CI/`create-next-app` default to root; `supabase/` already gives the backend its own directory. Caveat: Next config files share the root. Check `create-next-app` doesn't overwrite our `.gitignore` |
| 2026-11-03 | Tailwind first; shadcn/ui added component by component (over CSS Modules, or shadcn from day one) | Abdulrahman is learning, so plain Tailwind first, then shadcn/Radix for accessible pieces (dialogs, progress, radio groups). Components are copied into `components/ui/`, so we own them. Only one dev adds a given component at a time to avoid merge conflicts. Verify current Tailwind v4 / shadcn init steps against official docs at scaffold time |
| 2026-11-05 | ESLint + Prettier (over Biome, or Biome mixed in) | Standard `create-next-app` setup with `eslint-config-next` framework rules; Biome lacks those rules, and two formatters would fight. Use `eslint-config-prettier`, commit `.prettierrc`, add `lint` and `format:check` scripts (and later run them in CI) |
| 2026-11-05 | Supabase CLI as a project dependency (over global install) | Version pinned in the lockfile so both devs get identical local-stack, migration and type-gen behavior; fresh clone needs only `npm ci` + Docker. Wrap long `npx supabase` commands in `npm run` scripts (`db:start`, `db:types`, ...) |
| 2026-11-05 | Code under `src/` | Keeps the repo root to config files plus `supabase/`; separates app code from the backend folder |
| 2026-11-05 | React Compiler off | Abdulrahman is learning React; manual memoization shows when and why components re-render. Can be turned on later |
| 2026-11-05 | Classic caching (Cache Components off) | Matches the static generation + ISR plan; far more documentation. `create-next-app --yes` enabled it by default, so it was removed from `next.config.ts` |
| 2026-11-05 | Include `AGENTS.md`, imported from `CLAUDE.md` with `@AGENTS.md` | Next.js's agent guidance stays in its own file; project rules stay in `CLAUDE.md` |
| 2026-11-03 | Pin Node 24 (over 22) | Current LTS and what Abdulrahman already runs; Next.js needs >=20.9. Enforced with `.nvmrc`, `engines`, and `engine-strict=true` so a wrong Node fails at install |

## Progress log
- 2026-11-03: Planning session completed. Stack, content storage, auth, verification and reporting decided. Repo initialized with docs and `.gitignore`.
- 2026-11-03: Created the GitHub repo and pushed the first commit (`docs: initialize repo with project plan, build log, and gitignore`). Platform renamed from SuperDrive to SuperDriver; docs updated to match (repo name stays `super-driver`). Spotted that the ignore file was committed as `gitignore` without the dot.
- 2026-11-03: Fixed the ignore file name (`be607e4`). Collins invited and cloned the repo. Chose npm as the package manager, app at the repo root, and Node 24. Added `.nvmrc` and `.npmrc`.
- 2026-11-05: Settled the remaining scaffold options (Tailwind first with shadcn/ui on demand, ESLint + Prettier, Supabase CLI as a dependency, `src/`, React Compiler off, classic caching, `AGENTS.md`). Built the scaffold on `chore/scaffold-nextjs-supabase` (generated in a temp dir, then copied in so our `.gitignore` was not overwritten). First install hit an npm registry 404 for `electron-to-chromium@1.5.478` (published seconds earlier; resolved within minutes, no workaround needed). Verified: fresh `npm ci`, build, lint, `format:check`, `EBADENGINE` on a wrong Node. Nothing committed yet.
