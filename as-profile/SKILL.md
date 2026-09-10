---
name: as-profile
description: "Show or edit the ai-scaffold learning profile — global (~/.ai-scaffold/profile.md) or this project's (.scaffold/project.md). (ai-scaffold)"
allowed-tools:
  - Bash
  - Read
  - Write
---

# as-profile

```bash
cat ~/.ai-scaffold/profile.md 2>/dev/null    # the person
cat .scaffold/project.md 2>/dev/null         # this project
```

No global profile → that's `/as-setup`'s job; point there and stop.

**Show**: both files, briefly summarised in the user's language — occupation,
focus budget, pedagogy knobs, telemetry choice; then per-tech levels for this
project if present.

**Edit**: the user says what changed ("my focus is more like 90 minutes now",
"switch me to concept-first", "change my telemetry answer"); patch the exact
field, confirm in one line. Levels are not edited here — `/as-level` moves
them from evidence, except an explicit "I already know X, stop teaching it",
which is honoured directly.

**Forget**: on request, delete `~/.ai-scaffold/profile.md` and say what was
deleted. The file describes a person; a profile that is hard to erase is a
trap. Project files belong to the project — deleting `.scaffold/` is a `rm`
away and their call.
