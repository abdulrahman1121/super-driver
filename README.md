# SuperDriver

An interactive driver's-ed learning platform for Washington State. Short lessons, a few quick "check your understanding" questions after each section, and mastery-style progress, in a friendly Khan Academy-inspired look (all artwork is original).

**Live:** https://super-driver-seven.vercel.app

> SuperDriver is a study aid, not an official source. For the rules, always check the Washington State Driver Guide at dol.wa.gov.

## Status

|                    |                                                                                                                                                                                                |
| ------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Live now**       | 13 lessons (63 sections, 176 checks) from the official Driver Guide, answers graded by the database, choices shuffled on every visit, progress saved in the browser                            |
| **Planned for V1** | Scenario puzzles (road scenes drawn from data), timed 40-question practice test (80% to pass), guest sign-in with progress saved to the database, AI-assisted content review, report-a-problem |
| **Planned for V2** | State picker, Google sign-in, mini driving simulation                                                                                                                                          |

The two "Planned" rows are designed but not built. The honest list of shortcuts we took to ship the first version is in [CLAUDE.md](CLAUDE.md) under "Temporary shortcuts and debt".

## How it works

- Lessons live in Postgres (Supabase) and are pulled by Next.js on the server. Only rows marked `published` are readable by visitors.
- The browser never receives the correct answer. Choosing an option calls a database function (`check_choice`) that returns right or wrong plus an explanation. The columns that hold the answer and explanation are not readable by the public key.
- Each time a learner enters a lesson, the choices of every question are shuffled in the browser.
- Progress (which checks you got right) is stored in the browser's localStorage for now.

Diagrams of the data flow, the data model and the access rules are in [architecture/](architecture/README.md), each marked `built` or `planned`.

## Tech stack

| Layer   | Choice                                                                                                    |
| ------- | --------------------------------------------------------------------------------------------------------- |
| App     | Next.js 16 (App Router), React 19, TypeScript, Tailwind CSS 4                                             |
| Data    | Supabase: Postgres 17, row level security, a `SECURITY DEFINER` grading function                          |
| Hosting | Vercel (the app) and a hosted Supabase project (the database)                                             |
| Tooling | npm, Node 24, ESLint + Prettier, Supabase CLI with Docker for local development, pgTAP for database tests |

## Getting started

You need **Node 24** and **Docker Desktop** running.

```bash
nvm use                      # Node 24 (the repo pins it and refuses other versions)
npm ci                       # install exactly what the lockfile says
cp .env.example .env.local   # then fill in the two values from `npm run db:status`
npm run db:start             # local Supabase in Docker (first run downloads images)
npm run db:reset             # rebuilds the database and loads every lesson as a draft
npm run dev                  # then open http://localhost:3000
```

Open **`http://localhost:3000`**, not your machine's network address: on the network address the dev server blocks its scripts and the buttons do nothing.

Lessons load as drafts, so the site is empty until you publish some. Name the lessons you want to see:

```bash
sed "s/array\[\]::text\[\]/array['wa-traffic-signs','wa-hazards']/" supabase/publish.sql | docker exec -i supabase_db_SuperDriver psql -U postgres -v ON_ERROR_STOP=1
```

On Windows, run that from Git Bash. Local Supabase also gives you Studio at `http://localhost:54323` for browsing the tables.

### Scripts

| Command                                      | What it does                                                             |
| -------------------------------------------- | ------------------------------------------------------------------------ |
| `npm run dev` / `build` / `start`            | Next.js development, production build, production server                 |
| `npm run lint` / `format` / `format:check`   | ESLint, Prettier (write), Prettier (check only)                          |
| `npm run db:start` / `db:stop` / `db:status` | Start, stop, and show the keys and URLs of the local database            |
| `npm run db:reset`                           | Drop and rebuild the local database from the migrations and lesson files |
| `npm run db:test`                            | Run the database tests (permissions and content access)                  |
| `npm run db:types`                           | Regenerate TypeScript types from the schema                              |

## Project layout

```
src/app/          pages: the home page, lesson pages, error and 404 pages
src/components/   header, quiz, progress, lesson text
src/lib/          Supabase client, lesson queries, progress store, choice shuffle
supabase/
  migrations/     the database structure, in order (tables, security, grader)
  content/        one SQL file per lesson, named after the lesson ID
  tests/database/ pgTAP tests, including the security guard
  tools/          content-fingerprint.sql (proves content changes touched no data)
  publish.sql     the human publish step: makes only the lessons you name visible
architecture/     data-flow diagrams and a dated log of architecture changes
```

## Working with lesson content

- Every lesson is one file in `supabase/content/`. Rows are inserted as `draft`, so nothing reaches learners until it is published.
- A person checks each lesson against the official guide before it is published. There is no automated review yet.
- Publish by naming lessons in `supabase/publish.sql` (never edit the committed file). It refuses an unknown lesson, or any question that does not have exactly one correct choice.
- Every choice has an explanation, every section and question cites its Driver Guide section, and IDs are stable text keys that are never renamed.
- To prove that moving or editing content files changed no data, run the content fingerprint (see `supabase/tools/content-fingerprint.sql`).
- On the hosted database, content is applied by pasting SQL into the Supabase SQL editor. Do not paste a lesson that is already live: it resets that lesson to `draft`.

## Security in short

- A visitor with the public key can read published lessons and call the grader. Nothing else: no writes, and the answer columns are refused.
- Row level security limits which rows are visible, and column permissions limit which columns, and both are needed.
- New tables start with no access for the browser roles. A database test fails if a table lacks row level security, an answer column becomes readable, or a function is exposed without being allow-listed.
- The public key is safe to ship in the browser. The service-role key must never appear in this repo or in browser code.

## Testing

```bash
npm run lint && npm run format:check && npm run build && npm run db:test
```

There are no automated tests for the app code yet (the quiz, progress and error paths were checked by hand); that is on the debt list.

## Deployment

Pushing to `main` redeploys the app on Vercel. It needs two environment variables, `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` (the public key). The home page is cached and refreshes about once a minute; lesson pages render on every request, so newly published lessons appear without a redeploy. Database structure changes go through `supabase db push --remote`, never by editing the hosted database by hand.

## Contributing

- One branch per change, named `type/short-description` (`feat/`, `fix/`, `docs/`, `refactor/`, ...), merged by pull request with a squash merge. `main` must always work.
- Commits are one logical change each, with a single-line Conventional Commit message. Never commit `.env*` files.
- Update `architecture/` and the decisions log in `CLAUDE.md` in the same change as the code they describe.

## Project docs

- [CLAUDE.md](CLAUDE.md): the handoff document: decisions and their reasons, current state, the debt list, and the rules for content.
- [architecture/](architecture/README.md): diagrams and the architecture change log.
- [LOG.md](LOG.md): the build log and reflections.
- [AGENTS.md](AGENTS.md): notes for AI coding agents about this Next.js version.

## Team

Abdulrahman Elmi and Collins
