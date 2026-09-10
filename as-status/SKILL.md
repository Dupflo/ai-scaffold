---
name: as-status
description: "Where the project and the learning path stand: milestones shipped, current step, concepts seen and recalled. A map, not a score. (ai-scaffold)"
allowed-tools:
  - Bash
  - Read
---

# as-status

Read `.scaffold/` and show the map:

```
photo-booking — 3 of 7 milestones shipped

  ✓ 1. Spec                     spec-writing
  ✓ 2. Static pages             components, routing
  ✓ 3. Booking form             form-state, validation (recalled ✓)
  → 4. Save to database         sql-schema, migrations      <- current
    5. Auth                     …

  nextjs: level 1   postgres: level 0
  Concepts due for /as-quiz: 2
```

If decision-ledger is installed and has entries, add its one-line summary
(`ledger report --json`, thinnest area only). Two tools, one glance.

Rules, same as everywhere in this family: describe the path, never rate the
person; no percentages, no streaks, no "keep it up!". At most one factual
next-step line ("step 4 is sized for ~2 sessions at your focus budget").
Then stop.
