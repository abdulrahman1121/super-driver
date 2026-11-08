# Data flow

Status labels: **built**, **planned**, **pending decision**. Planned parts are dashed and grey. See [README.md](README.md) for how to update this file.

Last checked against the repo: 2026-11-07.

## 1. System overview

What exists today versus what is planned.

```mermaid
flowchart LR
  classDef built fill:#d1fae5,stroke:#059669,color:#064e3b
  classDef planned fill:#f3f4f6,stroke:#9ca3af,stroke-dasharray:5 5,color:#374151

  Dev["Developer machine<br/>npm scripts"]:::built
  Next["Next.js app<br/>(stock starter page only)"]:::built
  SB["Local Supabase in Docker<br/>Postgres, Auth, REST API, Studio"]:::built

  Browser["Learner's browser<br/>(guest)"]:::planned
  LS["localStorage<br/>pending-saves queue"]:::planned
  Reviewer["AI reviewer<br/>(script or Edge Function)"]:::planned
  Guide["WA Driver Guide text"]:::planned
  AI["AI model API"]:::planned
  Edge["Edge Function<br/>problem reports"]:::planned
  Mail["Email service"]:::planned
  GH["GitHub Issues"]:::planned

  Dev -->|"npm run dev"| Next
  Dev -->|"npm run db:start"| SB

  Browser -.->|"pages"| Next
  Next -.->|"supabase client (not installed yet)"| SB
  Browser -.-> LS
  LS -.->|"retry failed saves"| SB
  Reviewer -.->|"reads drafts, writes reviews"| SB
  Reviewer -.-> Guide
  Reviewer -.-> AI
  SB -.->|"webhook on new report"| Edge
  Edge -.-> Mail
  Edge -.-> GH
```

**Reading it:** today the Next.js app and the local database are two separate things that do not talk to each other. The app has no Supabase client and the database has no tables or migrations. Every dashed line is a decision that is made but not built.

## 2. Guest sign-in and saving progress (planned)

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

**Pending decision, answer visibility:** the correct answer must not be readable in the browser, so grading has to happen on the server. Whether the key lives in a column the client cannot select or in a separate key table is not yet decided. The "check your understanding" questions inside lessons need the same server-side check, one question at a time.

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

## 6. Data model (draft, not final, nothing built)

```mermaid
erDiagram
  lessons ||--o{ sections : contains
  questions ||--|{ choices : "has (separate table, decided)"
  questions ||--o{ content_reviews : "reviewed by"
  lessons ||--o{ content_reviews : "reviewed by"
  progress {
    uuid user_id "anonymous or Google user"
    text content_id "stable text key"
    text best_result
  }
  problem_reports {
    text content_type
    text content_id
    text phase
    text content_hash
    uuid user_id "anonymous allowed"
    text message
  }
  lessons {
    text id PK "stable key, never renamed"
    text state "WA only in V1"
    text status "draft, ai_reviewed, published"
    text source "Driver Guide section"
    text content_hash
  }
  sections {
    text id PK
    text status
    text source
    text content_hash
  }
  questions {
    text id PK
    text status
    text source
    text content_hash
  }
  choices {
    text id PK "stable, progress points at it"
    text question_id FK
    text body
  }
  content_reviews {
    text verdict
    text quote "must appear in the guide text"
    int page
    text content_hash "hash that was reviewed"
  }
```

**Open points (from `CLAUDE.md`):**
- How questions attach to lessons and sections is undecided, so that edge is not drawn.
- Where the correct-answer flag lives is **pending decision** and is intentionally not on `choices` above.
- The progress table name and shape are placeholders. The scenario data model is undecided and not shown.
- Progress rows reference stable text ids and choice ids, never array positions.
