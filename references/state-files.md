# ai-scaffold state files

Two layers, deliberately separate (the same split decision-ledger uses, for the
same reason):

```
~/.ai-scaffold/profile.md      local only, never committed.
                               Describes THE PERSON: who they are, how they
                               learn, how long they can focus.

.scaffold/                     in the project. Describes THE PROJECT'S
  project.md                   learning path: goal, stack, per-tech levels,
  curriculum.md                lessons tied to milestones, progress log.
  progress.md
```

On a solo project, commit `.scaffold/` — the path travels with the project.
On a shared repo, think before committing: per-tech levels describe a person.
`as-project` says this out loud once, at creation.

All files are markdown with YAML frontmatter: the agent is the only runtime,
so the format is optimised for an agent to read and patch, not for a script.

## `~/.ai-scaffold/profile.md`

```markdown
---
schema: 1
created_at: 2026-09-10
occupation: "UX designer"          # calibrates vocabulary and analogies
code_relationship: never           # never | tinkered | junior | professional
focus_minutes_per_day: 45          # sizes lessons and sessions (Deep Work)
pedagogy:
  entry: example-first             # example-first | concept-first
  error_tolerance: guided          # guided | trial-and-error
  analogies_from_occupation: true
telemetry: declined                # declined | accepted  (nothing is sent yet;
                                   #  the choice is recorded for when it exists)
---

Free-form notes the agent appends as it learns how this person learns.
Dated bullets, newest last.
```

Never put per-project data here. Never copy this file into a repo.

## `.scaffold/project.md`

```markdown
---
schema: 1
goal: "A webapp where clients book my photo sessions"
created_at: 2026-09-10
stack:
  - tech: nextjs
    level: 0        # 0 discover | 1 tinker | 2 junior | 3 autonomous
    why: "One framework covers pages, API and deployment; huge beginner ecosystem"
  - tech: postgres
    level: 0
    why: "Bookings are relational data; SQLite would need replacing at deploy"
  - tech: method    # always present: AI-driven project management is a
    level: 0        # competency like the others — spec-first, stories,
    why: "Piloting the agent is the skill that outlives this project"
---

## PRD (one page)
For: photography clients who book online instead of by DM.
Must: see available slots, book one, get a confirmation.
Out: payments, rescheduling, admin dashboard (v2).

Alternatives considered, one line each — kept so the choice can be revisited:
- Remix: equally good, smaller ecosystem for a first project.
```

Levels are **per technology, never global**. A junior in CSS can be a level 0
in SQL; one number would flatten exactly the signal that matters.

## `.scaffold/curriculum.md`

One `##` per project milestone, in build order. Each step is both a slice of
the project and a lesson: the concepts listed are what building that slice
teaches. Status moves `todo → current → done`; exactly one step is `current`.
On a product, a milestone is written as a user story with acceptance
criteria — the curriculum then demonstrates the method it teaches.

```markdown
## 3. Booking form (current)
story: A client picks a slot and books it without creating an account.
done-when: slot grid shows real availability; booking blocks the slot;
  confirmation appears on screen.
concepts: form-state, validation, controlled-inputs
lesson: not-started        # not-started | given | reformulated
```

## `.scaffold/progress.md`

Append-only log, one dated line per event. The agent writes it; nobody edits it.

```markdown
- 2026-09-10 lesson step-3 form-state — reformulated correctly
- 2026-09-12 quiz validation — recalled unaided (seen 2026-09-10)
```

## Deliberately absent

- **No score, no streak, no percentage complete.** `as-status` shows a map.
  The moment this file feeds a curve, it becomes an engagement metric.
- **No timing data.** How fast someone learned is not evidence of learning.
- **No copy of the ledger.** Structural decisions live in decision-ledger's
  `.mastery/index.json`; ai-scaffold reads it through the ledger runtime and
  never writes it directly.
