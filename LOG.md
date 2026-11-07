# SuperDriver Build Log

My personal record of building SuperDriver with Collins for TCSS 490.

## Planned (not implemented yet)

### Setup
- [x] Add Collins to the GitHub repo
- [x] Choose scaffold options: npm, app at root, `src/`, Tailwind first (shadcn/ui on demand), ESLint + Prettier, Supabase CLI as a dependency wrapped in npm scripts, React Compiler off, classic caching, `AGENTS.md` included
- [ ] Commit `package-lock.json` and the Node pin (`.nvmrc` + `engines`): files exist and are verified, waiting to be committed
- [ ] Decide who owns which features
- [ ] Scaffold Next.js + TypeScript + Supabase CLI (`chore/scaffold-nextjs-supabase`): built and verified, not committed yet
- [ ] Both of us set up Docker and run Supabase locally
- [ ] Finalize the database schema + RLS policies together (`feat/v1-database-schema`)

### V1 (WA only, guest-only, ~2 days)
- [ ] Lessons covering the WA Driver Guide and driving laws
- [ ] "Check your understanding" questions inside lessons
- [ ] Scenario puzzles: right-of-way, four-way stops, school zones
- [ ] Timed practice test: 40 random questions, 80% to pass, configurable timer
- [ ] Guest mode with anonymous Supabase users
- [ ] localStorage pending-saves queue for failed saves
- [ ] Progress dashboard
- [ ] AI content reviewer grounded in the Driver Guide, with verified citations and hash-based caching
- [ ] My approval step before anything is published
- [ ] Report-a-problem button everywhere → email + GitHub issue, with spam protection

### V2 (~2–3 days)
- [ ] State picker
- [ ] Google sign-in that keeps guest progress
- [ ] Account merging when a Google account already exists
- [ ] Gentle sign-in nudge
- [ ] Mini 2D driving simulation

## In Progress
- `chore/scaffold-nextjs-supabase`: scaffold built and checked; waiting on my approval to commit, push and open the PR

## Changelog (done)
- **2026-11-05**: Built the Next.js + Tailwind + ESLint/Prettier + Supabase CLI scaffold on `chore/scaffold-nextjs-supabase`. Checked it with a fresh `npm ci`, build, lint and format check, and saw `EBADENGINE` on a wrong Node version. Not committed yet.
- **2026-11-03**: Fixed the ignore file, which had been committed as `gitignore` without the dot (so git ignored nothing). Invited Collins and he cloned the repo. Picked npm, app at the repo root, and Node 24. Added `.nvmrc` and `.npmrc` to pin Node.
- **2026-11-03**: Created the GitHub repo and pushed the first commit (`.gitignore`, `CLAUDE.md`, `LOG.md`). Renamed the platform to SuperDriver.
- **2026-11-03**: Finished planning. Picked the stack, content storage, auth approach, verification pipeline and problem reporting. Named the platform (later renamed to SuperDriver).

## Decisions & Open Questions

### Decisions
- **2026-11-03: npm as the package manager.** It ships with Node and matches the Next.js and Supabase docs, so Collins installs nothing extra. pnpm and bun are faster, but that barely matters for a two-person, ~5-day project. We commit the lockfile, install with `npm ci`, and pin Node.
- **2026-11-03: App at the repo root, not `web/`.** One `package.json`, and Vercel/CI/`create-next-app` all default to the root. `supabase/` already gives the backend its own folder. The cost is Next.js config files sharing the root.
- **2026-11-03: Tailwind first, shadcn/ui added component by component.** I want to learn Tailwind directly before adding Radix and the `cn()` helper on top. shadcn copies component source into the repo, so we add only what we need (dialogs, progress bars, radio groups). Collins and I agree on one person adding a component and merging first, to avoid conflicts in `components/ui/` and `package.json`.
- **2026-11-05: ESLint + Prettier for linting and formatting.** It's what `create-next-app` and the Next.js docs assume, and `eslint-config-next` catches framework mistakes while I'm learning React. I considered Biome (one fast tool, but no Next.js-specific rules) and mixing Biome with ESLint/Prettier (two formatters would rewrite each other's output). Prettier settings live in the repo so Collins and I format identically.
- **2026-11-05: Supabase CLI as a project dependency.** Its version is pinned in `package-lock.json`, so Collins and I run identical `supabase start`, migration and type-generation behavior, and a fresh clone only needs `npm ci` plus Docker. The longer `npx supabase ...` commands get wrapped in `npm run` scripts (like `db:start` and `db:types`).
- **2026-11-03: Pin Node 24.** It's the current LTS and what I already run. `.nvmrc`, `engines` and `engine-strict` make a wrong Node version fail at install instead of causing weird bugs for Collins or me.
- **2026-11-03: Supabase tables for content.** Typed files or MDX would have been faster for V1, but I need a review workflow with statuses, and a database is the natural home for that. It also makes the random 40-question test and V2 progress easy.
- **2026-11-03: Supabase Auth, not Clerk.** One vendor, and RLS policies can use the logged-in user's ID directly.
- **2026-11-03: Anonymous sign-ins for guests.** Guests are real users from the start, so when they link Google in V2, their progress stays attached to the same ID.
- **2026-11-03: localStorage is only a backup queue.** Supabase is the source of truth. localStorage just holds saves that failed until they go through. If they disagree, keep the best result.
- **2026-11-03: Review content before it goes live, not on every page view.** AI checks each item once against the Driver Guide and must cite an exact quote, code checks the quote is real, and I approve before publishing. Content only gets re-reviewed if its hash changes.
- **2026-11-03: Reports go to email and GitHub issues.** One issue per content item, repeat reports become comments, plus a rate limit so my inbox doesn't flood.
- **2026-11-03: V1 is guest-only.** The sign-in nudge waits for V2, because a nudge without a working sign-in would be a broken promise.

### Open questions
- Who builds which features?
- How do we draw scenario puzzles in V1 (plain SVG, SVG + CSS, SVG + Motion)?
- Should the reviewer get the whole PDF or search chunks of it?
- Store question choices as JSON or as their own table?
- How do I approve content: Supabase dashboard or a small admin page?
- Which AI model runs the reviewer, and where (script or Edge Function)?
- Which email service?

## Reflections & Lessons Learned
- **A tool's `--yes` flag makes decisions for you.** `create-next-app --yes` quietly turned on Cache Components even though I had chosen classic caching. I only caught it by reading the generated `next.config.ts`. After any generator runs, read what it wrote and compare it with what you decided.
- **A lockfile pins versions, but it can't fix the registry.** My first install failed with a 404 for a package version that had been published seconds earlier, because the registry's metadata was ahead of its file storage. Waiting a few minutes fixed it. The lockfile did its job on the next try.
- **A guard you've never seen fail isn't proven.** `engine-strict` read `false` until `package.json` existed, and only a deliberately impossible `engines` value showed `EBADENGINE` actually blocking an install.
- **Where you put a check matters as much as the check itself.** Reviewing content on every page view sounded safe, but it would have shown users AI-edited text nobody verified and made answers change between visits. Reviewing once before publishing gives the same protection without the latency or cost.
- **A hash is a content fingerprint.** Any tiny edit changes it, which makes it a cheap way to know whether something needs re-reviewing.
- **A backup only helps if it fails differently than the thing it backs up.** localStorage can't save guests who clear their browser, because the Supabase session is stored there too. It's still useful for failed network saves.
- **RLS (Row Level Security)** is a per-row bouncer in the database. Since the Supabase key is public in the browser, RLS is what actually protects the data.
