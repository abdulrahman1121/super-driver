# Data flow

Status labels: **built**, **planned**, **pending decision**. Planned parts are dashed and grey. See [README.md](README.md) for how to update this file.

Last checked against the repo: 2026-11-08.

## 1. System overview

What exists today versus what is planned.

```mermaid
flowchart LR
  classDef built fill:#d1fae5,stroke:#059669,color:#064e3b
  classDef planned fill:#f3f4f6,stroke:#9ca3af,stroke-dasharray:5 5,color:#374151

  Dev["Developer machine<br/>npm scripts"]:::built
  Browser["Learner's browser<br/>(visitor, no sign-in)"]:::built
  Next["Next.js app<br/>home page, lesson pages,<br/>error and 404 pages"]:::built
  SB["Local Supabase in Docker<br/>Postgres + REST API<br/>learning tables, grader function"]:::built
  LS["localStorage<br/>best result per question<br/>(demo shortcut)"]:::built

  Vercel["Vercel hosting"]:::planned
  HSB["Hosted Supabase project"]:::planned
  Auth["Anonymous sign-in<br/>+ progress table"]:::planned
  Reviewer["AI reviewer<br/>(script or Edge Function)"]:::planned
  Guide["WA Driver Guide text"]:::planned
  AI["AI model API"]:::planned
  Edge["Edge Function<br/>problem reports"]:::planned
  Mail["Email service"]:::planned
  GH["GitHub Issues"]:::planned

  Dev -->|"npm run dev / db:start"| Next
  Dev -->|"npm run db:start"| SB
  Browser -->|"pages"| Next
  Next -->|"server reads published lessons"| SB
  Browser -->|"rpc check_choice (anon key)"| SB
  Browser --> LS

  Vercel -.->|"will host"| Next
  HSB -.->|"will replace the local database"| SB
  Browser -.-> Auth
  Auth -.->|"replaces localStorage as source of truth"| SB
  Reviewer -.->|"reads drafts, writes reviews"| SB
  Reviewer -.-> Guide
  Reviewer -.-> AI
  SB -.->|"webhook on new report"| Edge
  Edge -.-> Mail
  Edge -.-> GH
```

**Reading it:** the learning slice is built and runs locally. Lesson pages are rendered on the server from published rows in Supabase. The browser asks the database to grade each answer, and progress is kept only in this browser's localStorage, which is a temporary shortcut (see section 9). Hosting, sign-in with saved progress, the AI reviewer and problem reports are still planned. Every dashed line is a decision that is made but not built.

## 2. Guest sign-in and saving progress (planned)

> **Today (demo shortcut):** none of this is built. Progress is saved only in localStorage, with no sign-in and no Supabase save. This section is the design the shortcut will be replaced with. See section 9 and the debt list in `CLAUDE.md`.

Supabase is the source of truth. localStorage only holds saves that failed, until they succeed.

```mermaid
sequenceDiagram
  participant B as Browser
  participant LS as localStorage
  participant A as Supabase Auth
  participant DB as Postgres (RLS)

  B->>A: Anonymous sign-in (CAPTCHA)
  A-->>B: Session with real user id
  B->>LS: Write the progress update
  B->>DB: Save progress (as that user)
  alt save succeeds
    DB-->>B: Confirmed
    B->>LS: Remove the update
  else network or Supabase failure
    DB--xB: Error or timeout
    Note over B,LS: Update stays in the queue
    B->>DB: Retry on the next page load
  end
```

**Failure notes:**

- If sign-in itself fails, saves cannot be attributed to a user, so they wait in the queue.
- Clearing browser data deletes both the Supabase session and the queue, so that guest's progress is lost (accepted for V1).
- If the queue and Supabase disagree, the merge keeps the best result per item. The same merge function is reused for V2 account merging.
- Every retry must be safe to repeat, so a duplicate save does not corrupt progress.

## 3. Content publishing pipeline (planned)

Review happens once at write time, not on every page view.

```mermaid
stateDiagram-v2
  [*] --> draft: content row created or edited
  draft --> ai_reviewed: reviewer cites an exact quote and code finds it in the guide text
  ai_reviewed --> published: human approves
  ai_reviewed --> draft: reviewer rejects or the citation check fails
  published --> draft: any edit changes the content hash
```

**Built vs planned (2026-11-08, publish step updated 2026-11-14):** the `status` column, the published-only read policy, and a human publish step are built. `supabase/publish.sql` publishes only the lessons named in its list, so unchecked drafts stay hidden; it refuses an empty list, an unknown lesson ID, or a question in a named lesson that does not have exactly one correct choice. Lesson content is `supabase/seed.sql` (the first 4 lessons) plus one file per lesson in `supabase/content/`, all loaded by `db:reset`. The AI reviewer, the content hash, and the citation check are **not built** in the repo: lessons 5 to 13 were drafted and fact-checked by AI agents against the guide text in one session (2026-11-13), with their cited quotes checked by a script that is not in the repo, and a person still checks them before publishing.

**Planned (2026-11-11):** content moves to one SQL file per lesson group in `supabase/content/`, and the human publish step is limited to the lessons named. Today `publish.sql` publishes every row, so one checked lesson cannot be published on its own. Not built.

**What it enforces:** the read policy only exposes `published` rows, so learners cannot see unreviewed content. The reviewer only runs when a row's content hash differs from the last reviewed hash, so unchanged content is never reviewed or paid for twice.

## 4. Practice test (planned, one part pending decision)

The test draws 40 questions at random from the whole pool and needs 80% (32 of 40) to pass.

```mermaid
sequenceDiagram
  participant B as Browser
  participant DB as Postgres

  B->>DB: rpc: draw a test (40 random published questions)
  DB-->>B: Questions and choice text and ids (no correctness)
  Note over B: Learner answers, timer runs (config value)
  B->>DB: rpc: submit the chosen choice ids
  Note over DB: Grades against the answer key on the server
  DB-->>B: Score, pass or fail, and the explanations
```

**Answer visibility (decided, option A):** the correct answer must not be readable in the browser, so grading happens on the server. `is_correct` and `explanation` sit on `choices`, but the browser roles can only select `id`, `question_id` and `body`, and a `SECURITY DEFINER` function does the grading. This was tested against local Supabase and held up.

**Pending design, per-choice checking:** the "check your understanding" questions inside lessons need a check one question at a time. But a per-choice check is an answer-key oracle: anyone can loop over the choice ids and learn which is correct (shown in testing). That is acceptable in lessons (the lesson checks use `check_choice`, built on 2026-11-08, see section 9), but the practice test must grade the whole submission at once, and test questions need protection from per-choice checking. How is not designed yet.

**Failure notes:** if submitting fails, answers stay in the browser and the learner can retry. If the timer config is missing, a default must be used. A test with fewer than 40 published questions in the pool must fail clearly instead of returning a short test.

## 5. Report a problem (planned, owner: Collins)

```mermaid
sequenceDiagram
  participant B as Browser
  participant DB as Postgres
  participant E as Edge Function
  participant M as Email
  participant G as GitHub

  B->>DB: Insert report (content type and id, phase, content hash, message)
  Note over DB: Insert-only for users, with a per-user rate limit
  DB->>E: Webhook on insert
  E->>G: Open an issue, or add a comment if one is open for this item
  E->>M: Send a batched or deduplicated email
```

**Failure notes:**

- If GitHub or email is down, the report is still safely stored in the table, and the function must be able to retry later without opening a duplicate issue.
- The GitHub token (fine-grained, Issues write only) and the email key live only as Edge Function secrets, never in the browser.
- Users can insert reports but can never read anyone else's.

## 6. Data model (learning tables built, the rest draft)

```mermaid
erDiagram
  lessons ||--o{ sections : contains
  sections ||--o{ questions : "has (section-owned, decided)"
  questions ||--|{ choices : "has (separate table, decided)"
  progress {
    uuid user_id "PLANNED: anonymous or Google user"
    text content_id "stable text key"
    text best_result
  }
  problem_reports {
    text content_type "PLANNED"
    text content_id
    text phase
    text content_hash
    uuid user_id "anonymous allowed"
    text message
  }
  lessons {
    text id PK "stable key, never renamed"
    text state "WA only in V1"
    int position
    text title
    text summary
    text source "Driver Guide section"
    text status "draft, ai_reviewed, published (browser cannot read)"
  }
  sections {
    text id PK
    text lesson_id FK
    int position
    text title
    text body "plain text, blank line = paragraph, dash = bullet"
    text source
    text status "browser cannot read"
  }
  questions {
    text id PK
    text section_id FK
    int position
    text prompt
    text source
    text status "browser can read (see note)"
  }
  choices {
    text id PK "stable, progress points at it"
    text question_id FK
    int position
    text body "browser can read"
    bool is_correct "browser cannot read"
    text explanation "browser cannot read"
  }
  scenarios {
    text id PK "PLANNED, stable key"
    int schema_version "scene format version"
    jsonb scene "browser can read, draws the picture"
    text description "required, plain-language fallback"
    text status "draft, ai_reviewed, published"
    text content_hash "covers the scene too"
  }
  content_reviews {
    text verdict "PLANNED"
    text quote "must appear in the guide text"
    int page
    text content_hash "hash that was reviewed"
  }
```

**Built (checked against `supabase/migrations/20261108120000_learning_content.sql`):** `lessons`, `sections`, `questions` and `choices`. The other tables in the diagram are planned. There is no `content_hash` column yet (debt).

**Decided and built:**

- Questions belong to a section (`questions.section_id`). Cost: the later practice test has to query across sections, or the schema changes.
- A unique index allows at most one correct choice per question. "At least one" cannot be a table constraint, so `publish.sql` checks it before publishing.
- `choices` has no status of its own. Its read policy follows its question's status.
- `questions.status` is readable by the browser roles, unlike the other tables, because the `choices` policy reads it and a policy that reads another table is checked against the caller's column privileges (found by a failing test). It always reads `published` for a visitor, so it leaks nothing.

**Still open:**

- The progress table name and shape are placeholders.
- `scenarios` is drawn but not connected: how a scenario attaches to a question is undecided. The solution is never stored on the scenario.
- Progress rows reference stable text ids and choice ids, never array positions.

## 7. Who can reach what: access control layers

Every browser request passes the same gates before it touches data. All three gates, the grading function and the guard tests are built for the learning tables.

```mermaid
flowchart TB
  classDef built fill:#d1fae5,stroke:#059669,color:#064e3b
  classDef planned fill:#f3f4f6,stroke:#9ca3af,stroke-dasharray:5 5,color:#374151

  Browser["Browser<br/>visitor = anon role<br/>guest = authenticated role"]:::built
  API["Supabase API<br/>(PostgREST)"]:::built
  G1{"Gate 1: table privileges<br/>new tables grant nothing by default"}:::built
  G2{"Gate 2: column privileges<br/>is_correct and explanation not granted"}:::built
  G3{"Gate 3: RLS<br/>published rows only"}:::built
  Data[("Content tables")]:::built
  Fn["check_choice function<br/>(SECURITY DEFINER)"]:::built
  Server["Server-side code<br/>service_role"]:::built
  Guard["Guard test: npm run db:test"]:::built

  Browser --> API --> G1 --> G2 --> G3 --> Data
  Browser -->|"rpc: check one choice"| Fn
  Fn -->|"runs as owner, reads the hidden columns"| Data
  Fn -->|"returns right/wrong and the explanation"| Browser
  Server ==>|"bypasses the gates"| Data
  Guard -.->|"fails the build if a gate is loosened"| G1
```

**What it shows:** a request is refused at the first gate that says no. Gate 1 is a migration that makes new tables, sequences and functions closed to the browser roles until a later migration grants access on purpose. Gates 2 and 3 are the column grants and row policies on the four learning tables. `check_choice` is the only way the browser learns whether an answer is right, and it gets back right or wrong plus the explanation.

**Why this shape:** the browser holds a public key, so the database has to enforce access. RLS limits rows and column privileges limit columns, and we need both. Server-side code uses `service_role` and bypasses the gates, so that key must never reach the browser.

**Failure notes:**

- A forgotten grant fails closed: the developer sees "permission denied" and the data stays hidden.
- Someone granting too much on purpose, or following the misleading error hint that suggests a table-wide `SELECT`, is caught by the guard test, which fails if a table lacks RLS, an answer column is readable, or a function is callable without being on the allow-list.
- `check_choice` is an answer-key oracle if someone loops over it (accepted for lesson checks; it is on the guard test's allow-list on purpose, and it has no rate limit yet, which is debt). The practice test has to grade the whole submission at once (design pending).
- Verified on 2026-11-08 against the real REST API as a visitor: `select=*` and `is_correct` are refused, writes are refused, and grading works for right, wrong and unknown choices. 22 database checks pass (`npm run db:test`).
- Not verified: GraphQL (extension off locally) and the hosted project's default grants.

## 8. Scenario data: validation and fallback (planned)

A scenario scene is data drawn in the browser, so bad data has to be stopped early and must never leave the learner stuck.

```mermaid
flowchart LR
  classDef planned fill:#f3f4f6,stroke:#9ca3af,stroke-dasharray:5 5,color:#374151

  Author["Scene written<br/>(seed SQL)"]:::planned
  V1{"Write-time validation<br/>shape, known types,<br/>bounds, no overlaps"}:::planned
  V2{"Database check<br/>object with schema_version"}:::planned
  Row[("scenarios row<br/>status: draft")]:::planned
  Review["Human reviews a rendered<br/>preview next to the text description"]:::planned
  Pub[("published")]:::planned
  Render["Browser draws the scene<br/>inside an error boundary"]:::planned
  Fallback["Shows the text description<br/>and the question still works"]:::planned

  Author --> V1
  V1 -->|"fails: stops CI"| Author
  V1 --> V2 --> Row --> Review
  Review -->|"approved"| Pub
  Review -->|"rejected or edited"| Row
  Pub --> Render
  Render -->|"scene fails to draw"| Fallback
```

**What it shows:** three places a bad scene can be caught (when written, in the database, and while drawing), plus the human check. Any edit changes the content hash, which returns the scenario to `draft`.

**Failure notes:**

- The AI reviewer checks the written explanation against the Driver Guide but cannot see the picture, so the human preview is the only check that the scene matches its description.
- If the scene fails to draw, the learner still sees the required text description and can answer, so a bad scene degrades a lesson instead of blocking it.
- The scene format carries a `schema_version`, so old and new formats can coexist when the format changes.
- Not verified: whether the database-level JSON-schema extension (`pg_jsonschema`) is available locally; the first version may validate in a script instead.

## 9. Learning: reading a lesson and checking an answer (built)

```mermaid
sequenceDiagram
  participant B as Browser
  participant N as Next.js server
  participant DB as Supabase (REST + Postgres)
  participant LS as localStorage

  B->>N: GET /lessons/wa-speed-space
  N->>DB: select lesson, sections, questions, choices (safe columns, published rows only)
  alt database answers
    DB-->>N: Rows (no is_correct, no explanation)
    N-->>B: Lesson page
  else timeout or error
    Note over N,DB: 8 s timeout, one retry, then give up (about 16 s worst case)
    N-->>B: Friendly error page with Try again
  end
  B->>DB: rpc check_choice(choice id)
  alt answered
    DB-->>B: is_correct and explanation
    B->>LS: Record best result for the question
    B->>B: Show Correct or Not quite, with the explanation
  else network failure or timeout
    DB--xB: Error
    Note over B: Nothing is recorded, the learner sees a message and Retry
  end
```

**What it shows:** pages are rendered on the server and never contain answers. Each answer is graded by the database, one choice at a time, and only then does the browser learn whether it was right. The home page is built ahead of time and refreshed at most once a minute (ISR). Lesson pages are rendered on request.

**Temporary shortcuts (debt, see `CLAUDE.md`):** progress lives only in this browser's localStorage, with no sign-in and no database copy, so clearing browser data erases it and it does not follow the learner to another device. The decided design (section 2) replaces it.

**Failure notes (each one was triggered and checked on 2026-11-08):**

- Database frozen (not just down): the page fails after about 16 seconds, not forever. Measured: an earlier version took over a minute because supabase-js's own retries stacked with ours; the library's retry is now off.
- Error page "Try again" must refetch server data. The first version used `reset()`, which kept showing the same failure after the database recovered; it now uses `retry()`.
- Network drop during a check: a message and Retry, nothing recorded, and Retry works once the network is back.
- Unknown or unpublished lesson: a normal 404, not an error.
- Corrupt or hand-edited localStorage (bad JSON, wrong shape) is ignored, and the page still renders.
- localStorage blocked: progress still works for the current visit, held in memory.
- Not verified: behavior on a hosted Supabase project, and on phones or other browsers.
