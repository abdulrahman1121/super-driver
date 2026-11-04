# SuperDrive Build Log

My personal record of building SuperDrive with Collins for TCSS 490.

## Planned (not implemented yet)

### Setup
- [ ] Create the `super-driver` GitHub repo and add Collins
- [ ] Decide who owns which features
- [ ] Scaffold Next.js + TypeScript + Supabase CLI (`chore/scaffold-nextjs-supabase`)
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
- Repo setup on `main`: `.gitignore`, `CLAUDE.md`, `LOG.md`

## Changelog (done)
- **2026-11-03**: Finished planning. Picked the stack, content storage, auth approach, verification pipeline and problem reporting. Named the platform SuperDrive and the repo `super-driver`.

## Decisions & Open Questions

### Decisions
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
- **Where you put a check matters as much as the check itself.** Reviewing content on every page view sounded safe, but it would have shown users AI-edited text nobody verified and made answers change between visits. Reviewing once before publishing gives the same protection without the latency or cost.
- **A hash is a content fingerprint.** Any tiny edit changes it, which makes it a cheap way to know whether something needs re-reviewing.
- **A backup only helps if it fails differently than the thing it backs up.** localStorage can't save guests who clear their browser, because the Supabase session is stored there too. It's still useful for failed network saves.
- **RLS (Row Level Security)** is a per-row bouncer in the database. Since the Supabase key is public in the browser, RLS is what actually protects the data.
