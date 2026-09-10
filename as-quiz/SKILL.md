---
name: as-quiz
description: "Retrieval practice on concepts from past lessons, grounded in the project's own code. Run on request, never mid-task. (ai-scaffold)"
allowed-tools:
  - Bash
  - Read
  - Write
  - Grep
  - Glob
---

# as-quiz

Spaced retrieval is the one pedagogy lever with strong evidence behind it,
and the one AI-assisted building skips entirely. This makes it opt-in: the
user runs `/as-quiz` when they want it. Never fire one unrequested.

## Picking questions

Read `.scaffold/progress.md`. Eligible: concepts whose last event is **3 or
more days old** — recall too soon is recognition, not retrieval. Prefer the
oldest, cap at **three questions**, one at a time.

Every question is grounded in this repo:

> In `app/booking/form.tsx`, why does the input value live in a `useState`
> instead of just reading the DOM?

is answerable only by someone who understood their own project. "What is
controlled input?" is trivia; never ask it.

## Judging and recording

Same honesty rules as the mentor: a right answer with the why is recalled; a
right answer without the why gets exactly one follow-up; "I don't know" gets
a three-line re-explanation anchored in the file, no ceremony, and the
concept becomes eligible again sooner.

Append one line per question to `progress.md` (`recalled unaided` /
`recalled with help` / `re-explained`). No score, no total, no streak.

If a recalled concept was ever an `unknown` in decision-ledger, that is a
transfer — record it through the ledger runtime (`--revisit-of`), because
that file is where transfer evidence lives, not here.
