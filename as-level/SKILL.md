---
name: as-level
description: "Reassess the user's level on one technology of the current project, from evidence, and adjust the mentor's behaviour. (ai-scaffold)"
allowed-tools:
  - Bash
  - Read
  - Write
  - Grep
  - Glob
---

# as-level

Levels drift in one direction during a project: up. This skill moves the
number in `.scaffold/project.md` so the mentor's behaviour follows.

## Evidence before questions

Read `progress.md` first. Concepts `recalled unaided`, gaps filled at level 1,
reformulations that got sharper — that is the evidence. Only where it is
ambiguous, ask at most two grounded questions (the `/as-project` kind, never
trivia).

Promote one level at a time. A level 0 who shipped three milestones is a
level 1, not a level 3 — the next project will finish the job.

## Demotion exists

The user can say "go back to explaining more" — that's a demotion request,
honour it without comment. Struggling at a promoted level is signal, not
failure; quietly step the behaviour down before stepping the number down.

## Close

One line: which tech moved, from what to what, and what changes in practice
("fewer gaps to fill in React, explanations continue in SQL"). Update
`project.md`, append one line to `progress.md`. No congratulations ceremony —
the shipped project is the reward, not a rank.
