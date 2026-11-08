# Architecture

Living documentation of what SuperDriver does and how data moves through it. It is updated **in the same commit/PR as the change it describes**, never in a batch at the end.

| File | What it covers |
|---|---|
| [data-flow.md](data-flow.md) | Diagrams: system overview, the key user flows, and the data model |
| [changes.md](changes.md) | Dated log of every architecture change, with the reasoning |

## Status labels

Every component and flow is labelled so the diagrams never overstate reality:

- **built**: exists in the repo and was checked
- **planned**: decided (see the Decisions log in `CLAUDE.md`) but not built
- **pending decision**: a design question is still open

Planned things are drawn with dashed lines and a grey fill in the diagrams.

## How to update

1. When a decision is made or code changes how data moves, edit the matching diagram in `data-flow.md`.
2. Add a dated entry to `changes.md` (what changed, why, link to the Decisions log entry).
3. Check the diagram against the real code, schema, or migrations, not memory. Flip `planned` to `built` only after the thing runs.
4. Keep each diagram focused on one thing. Split a diagram that gets crowded.

Diagrams are [Mermaid](https://mermaid.js.org/) in Markdown: GitHub renders them, and they diff cleanly in git.
