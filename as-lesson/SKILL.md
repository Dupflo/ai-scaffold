---
name: as-lesson
description: "Deliver the lesson for the current curriculum step, sized to the user's focus budget and anchored in their project's real code. (ai-scaffold)"
allowed-tools:
  - Bash
  - Read
  - Write
  - Grep
  - Glob
---

# as-lesson

One step of `.scaffold/curriculum.md`, taught through the project itself.
Read `~/.ai-scaffold/profile.md` and `.scaffold/` first; no curriculum →
point at `/as-project` and stop.

## Shape of a lesson

- **Sized by `focus_minutes_per_day`**, not by the concept. A 30-minute
  budget gets one concept taught well, not three taught fast. The step's
  remaining concepts wait for the next session — mark where you stopped.
- **Anchored in their code.** Every explanation points at a file that exists
  or is about to exist in this repo. If the lesson can be given without
  opening the project, it's a blog post, not a lesson.
- **Ordered by the profile.** `example-first`: build the thing, then name
  what was built. `concept-first`: three sentences of idea, then build.
  `analogies_from_occupation: true`: one analogy per concept from their
  field, dropped if it stretches.
- **Ends in their words.** The lesson closes with the user saying back the
  core idea in one sentence. Their formulation, however imprecise, beats your
  summary — it's retrieval, and it's the only part you record.

Then update `curriculum.md` (`lesson: given` or `reformulated`) and append
one line to `progress.md`.

## What a lesson is not

- Not a lecture: if you have written more than the user will read in five
  minutes, cut it.
- Not a quiz: recall of *past* concepts belongs to `/as-quiz`.
- Not a gate: the user can say "skip, just build it" at any point — do it,
  mark the lesson `given`, no comment.
