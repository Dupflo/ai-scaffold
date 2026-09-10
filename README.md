# ai-scaffold

*Eight agent skills for Claude Code that turn the agent into an adaptive
mentor: it teaches at your level — from first line of code to autonomous —
while your real project ships.*

**The place where "I don't know" makes sense.**

People aren't afraid of jumping into coding with AI anymore. They're afraid of
understanding nothing about what just got built. What's missing isn't courage,
it's a harness: project-first learning, adapted to the level you actually
have, not the curriculum someone imagined for you.

The reference user: a UX designer who has never written a line of JavaScript,
knows the word "responsive", can't write CSS — and ships their webapp *and*
can explain how it works.

> **Status: early.** Concept and skeleton. Being dogfooded on the author's
> own projects first.

## The skills

Only `/as-mentor` loads on its own — it adapts every coding turn to your
level. The rest are commands.

| Skill | When |
|---|---|
| `/as-setup` | Once per machine. Profile questionnaire + dependency check. |
| `/as-profile` | Show or edit your profile. |
| `/as-project` | Once per project. Goal, proposed stack, per-tech levels, curriculum. |
| `/as-mentor` | Loads itself during coding when `.scaffold/` exists. |
| `/as-lesson` | The lesson for the current milestone, sized to your focus budget. |
| `/as-quiz` | Retrieval practice on past concepts, in your own code. Opt-in. |
| `/as-level` | Move a tech's level from evidence. |
| `/as-status` | The map: milestones, concepts, levels. Never a score. |

## Principles

- **Project-first.** You learn what your project needs, when it needs it.
  Every milestone ships something you can see working.
- **Levels are per technology, per project.** A junior in CSS can be a
  level 0 in SQL. One number would erase the signal.
- **The illusion of competence is the enemy.** The AI does, you believe you
  know. Reformulation, retrieval, and the decision ledger exist to close that
  gap — without ever blocking the build.
- **Never a gate.** Code is written in the same turn, at every level.
  "Just build it" always works, and works the first time you say it.
- **No learning-styles folklore.** The profile asks what has evidence behind
  it (prior knowledge, example-first vs concept-first, focus budget), not
  whether you are "visual".
- **A map, not a score.** No streaks, no percentages, no praise ceremonies.

## Works with decision-ledger

Structural decisions (data model, auth, state ownership…) are
[decision-ledger](https://github.com/Dupflo/decision-ledger)'s territory:
ai-scaffold hands off to it rather than duplicating it, and reads it back in
`/as-status`. The dependency is runtime-only — the ledger stays an independent
package, and updating it updates what ai-scaffold uses. Requires ledger
`>= 0.2.0` (`ledger --version`); without it, ai-scaffold still works and says
so once.

## Install

```bash
/plugin marketplace add Dupflo/ai-scaffold
/plugin install ai-scaffold@dupflo-ai-scaffold
```

Or by script, global (`~/.claude/skills`) by default:

```bash
curl -fsSL https://raw.githubusercontent.com/Dupflo/ai-scaffold/main/install.sh | bash
./install.sh --project     # this repo only
./install.sh --uninstall   # removes the symlinks, keeps your profiles
```

Then run `/as-setup` once, and `/as-project` in the repo you want to build.

## State

`~/.ai-scaffold/profile.md` describes **you** — local only, never committed.
`.scaffold/` in each project describes **that project's learning path** —
commit it on a solo project. Formats in
[`references/state-files.md`](references/state-files.md). Telemetry: nothing
is sent, ever, in this version; `/as-setup` records the choice for when the
feature exists.

## License

MIT.
