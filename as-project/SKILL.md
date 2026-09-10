---
name: as-project
description: "Onboard the current project into ai-scaffold: capture the goal, propose a justified default stack, assess the user's level per technology, and generate a curriculum where each project milestone is a lesson. (ai-scaffold)"
allowed-tools:
  - Bash
  - Read
  - Write
  - Grep
  - Glob
  - AskUserQuestion
---

# as-project

Turns "I want to build X" into `.scaffold/`: a stack the user didn't have to
choose alone, honest per-tech levels, and a curriculum that IS the project
plan. Formats in `references/state-files.md` (in the ai-scaffold install).

Requires the global profile; missing → run `/as-setup` first, then come back.
`.scaffold/project.md` already present → this is an update, not an onboarding:
re-read it, ask what changed, patch.

## 1. The goal, in their words — then a one-page PRD

One question: what do you want to exist at the end? Capture it verbatim in
`project.md`. A goal stated in the user's own vocabulary is the reference every
lesson gets anchored to.

When the project is a product (it has users who aren't its builder), turn
the answer into a **one-page PRD** at the top of `project.md`: who it's for,
what it must do, what is explicitly out. At level 0 in method, don't say
"PRD" first — say "the one-page contract of what we're building", write it
together, then name it: *this is what the industry calls a PRD*. Vocabulary
lands after the thing it names, never before.

If the repo already has code, read it first (structure, package manifests)
— the stack may already be chosen, and the audit-style question "why this?"
belongs to `/ledger-audit`, not here.

## 2. The stack: propose, don't enumerate

A project can be built with many stacks, and a beginner cannot arbitrate
between five frameworks — presenting the menu anyway is abdication dressed as
neutrality. So:

- **Propose one default stack**, justified in three sentences maximum, biased
  toward: fewest moving parts, best beginner ecosystem, hardest to outgrow.
- List the serious alternatives **one line each**, kept in `project.md` so the
  choice can be revisited when the user can arbitrate it.
- `code_relationship: junior` or `professional` in the profile → invert:
  ask their preference first, propose only if they defer.

If decision-ledger is installed, record the stack choice through it — it is
the project's first structural decision. The user accepting your default is
`unknown` or `partial`, and that's fine and normal; say so without ceremony.

## 3. Levels, per technology — and method is one of them

**Always add `method` (AI-driven project management: spec-first, stories,
review, ship) to the stack, with its own level.** Piloting an agent is a
competency like the others, usually the one the user came to learn without
knowing its name — and for a user who will never write much code themselves,
it is the competency that outlives the project.

For each tech in the stack, set a level (0 discover / 1 tinker / 2 junior /
3 autonomous). Start from the profile's `code_relationship`, then verify with
at most **two** questions per tech where it matters — concrete ones ("have you
written CSS that had to work on mobile and desktop?"), never trivia. People
mis-estimate themselves in both directions; two grounded questions beat a
self-rating. Cap the whole pass at 5 questions: levels self-correct later
through `/as-level`.

## 4. The curriculum

Break the project into milestones in build order — for levels 0–1 in method,
spec-first: the first milestone is writing the one-page PRD together, which
is itself the first lesson. Each milestone gets:

- the slice of product it ships (the user can see it work),
- the 2–4 concepts building it will teach,
- `status` / `lesson` fields per the schema.

**When the project is a product, shape each milestone as a user story with
acceptance criteria** — "A jury member can open any document without leaving
the site. Done when: viewer opens PDFs and images; back button returns to
the section." — because then the curriculum doesn't just *use* the method,
it *demonstrates* it: by the end, the user has watched need → story →
acceptance → build → review happen five to nine times on their own project.
That repetition is the method lesson; no chapter about agile needed. At
method level 2+, flip it: the user writes the story, the agent critiques it.

Every step must ship something visible. A learner funds their motivation with
working software, not with completed chapters. 5–9 milestones; more means the
slices are too thin, fewer means they're too big for the focus budget.

## 5. Close

Write the three files, then say two things only: which milestone is `current`,
and that `/as-lesson` starts it. If `.scaffold/` is being created in a repo
with other committers, add one line: these files describe a learning path —
commit them on a solo project, think first on a shared one.
