---
name: as-setup
description: "Entry point for ai-scaffold: check whether a global learning profile exists, run the first-time questionnaire if not, and verify dependencies (decision-ledger). Run once per machine, or to redo onboarding. (ai-scaffold)"
allowed-tools:
  - Bash
  - Read
  - Write
  - AskUserQuestion
---

# as-setup

One entry point, three checks. Idempotent: safe to run again any time.

## 1. Profile check

```bash
cat ~/.ai-scaffold/profile.md 2>/dev/null
```

Exists → say so, show a two-line summary, point at `/as-profile` to edit and
`/as-project` to onboard a project. Done.

Missing → run the questionnaire below.

## 2. The questionnaire

Five questions, one at a time, in the user's language. This is a conversation,
not a form: accept free-text answers and map them yourself. Write the result
to `~/.ai-scaffold/profile.md` in the format of `references/state-files.md`
(in the ai-scaffold install).

1. **What do you do for a living (or study)?** — calibrates vocabulary and
   analogies. A junior developer and a mason get different explanations of the
   same concept, and both deserve good ones.
2. **What's your relationship with code so far?** — never touched it /
   tinkered with snippets / junior dev / professional. This is the starting
   default; real levels are set per technology, per project, in `/as-project`.
3. **On a project you care about, how long can you stay focused in a day?**
   — honest answers range from 20 minutes to 4 hours. Sizes every lesson.
4. **When you learn something new: example first, or the idea first?** Plus
   one follow-up: would you rather try and be corrected, or be guided and not
   fail? These two answers are the pedagogy knobs. Do NOT ask about
   visual/auditory "learning styles" — matching those has no evidence behind
   it; prior knowledge and retrieval practice do.
5. **Telemetry** — exactly three options:
   - Yes
   - No
   - What is telemetry? → explain in three sentences (what would be sent,
     that it is anonymous, that nothing is sent today — the choice is being
     recorded for when the feature exists), then ask again with two options.

   Record the choice. **Nothing is ever sent in this version**, whatever the
   answer. Never re-ask on later runs.

## 3. Dependency check

```bash
~/.claude/skills/decision-ledger/bin/ledger --version 2>/dev/null
```

- Prints `ledger 0.2.0` or higher → good, say nothing.
- Missing or older → offer once:

```bash
curl -fsSL https://raw.githubusercontent.com/Dupflo/decision-ledger/main/install.sh | bash
```

Declined → fine. ai-scaffold works without it; structural decisions just go
unrecorded. Note the absence in one line and move on. Never block on it.

## Close

End with exactly one suggestion: `/as-project` in the repo they want to build
in. Not a tour of the other six skills.
