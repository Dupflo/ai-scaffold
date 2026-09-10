#!/usr/bin/env bash
set -euo pipefail

# ai-scaffold installer
#
# Usage:
#   ./install.sh                 Global (~/.claude/skills), available in every repo. Default.
#   ./install.sh --project       This repo only (./.claude/skills)
#   ./install.sh --uninstall     Remove the symlinks; keeps your profiles
#
# Global is the default on purpose: the learning profile describes a person,
# not a repo, and should follow them into every project.
#
# The repo is public, so this works from anywhere:
#   curl -fsSL https://raw.githubusercontent.com/Dupflo/ai-scaffold/main/install.sh | bash

REPO="https://github.com/Dupflo/ai-scaffold.git"
SKILLS="as-setup as-profile as-project as-mentor as-lesson as-quiz as-level as-status"

SCOPE="global"
UNINSTALL=0
while [ $# -gt 0 ]; do
    case "$1" in
        --project|-p)   SCOPE="project" ;;
        --global|-g)    SCOPE="global" ;;
        --uninstall|-u) UNINSTALL=1 ;;
        -h|--help)      sed -n '3,16p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
        *)              echo "unknown option: $1" >&2; exit 2 ;;
    esac
    shift
done

if [ "$SCOPE" = "global" ]; then
    DEST="$HOME/.claude/skills"
else
    DEST="$PWD/.claude/skills"
fi
HOME_DIR="$DEST/ai-scaffold"

if [ "$UNINSTALL" -eq 1 ]; then
    for s in $SKILLS; do rm -f "$DEST/$s"; done
    echo "Removed the $SCOPE symlinks."
    echo "$HOME_DIR is still there; delete it by hand if you want it gone."
    echo "Your profiles are untouched: ~/.ai-scaffold/ and .scaffold/ in each project."
    exit 0
fi

# Payload: the files next to this script when run from a clone, otherwise
# clone it (the curl | bash case). The marker checked is this plugin's own
# reference file, not just a generic path, so a stray bin/ in the current
# directory can't be mistaken for the payload.
SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"

mkdir -p "$DEST"

if [ -n "${SELF_DIR:-}" ] && [ -f "$SELF_DIR/as-mentor/SKILL.md" ] && [ -f "$SELF_DIR/references/state-files.md" ]; then
    SRC="$SELF_DIR"
    if [ "$(cd "$SRC" && pwd -P)" != "$(cd "$HOME_DIR" 2>/dev/null && pwd -P || echo none)" ]; then
        rm -rf "$HOME_DIR"
        mkdir -p "$HOME_DIR"
        (cd "$SRC" && tar cf - references assets $SKILLS README.md LICENSE 2>/dev/null) \
            | (cd "$HOME_DIR" && tar xf -)
    fi
    echo "→ Installed from $SRC"
elif [ -d "$HOME_DIR/.git" ]; then
    git -C "$HOME_DIR" pull --ff-only --quiet
    echo "→ Updated $HOME_DIR"
else
    echo "→ Fetching ai-scaffold…"
    if ! git clone --depth 1 --quiet "$REPO" "$HOME_DIR"; then
        echo "" >&2
        echo "Clone failed. Check that git is installed and you can reach GitHub." >&2
        exit 1
    fi
fi

# The scaffold rises one bar per pair of skills linked. Cosmetic, and the
# point: the install already looks like what the tool does.
BARS=""
i=0
for s in $SKILLS; do
    ln -sfn "$HOME_DIR/$s" "$DEST/$s"
    i=$((i + 1))
    case $i in 2|4|6|8) BARS="$BARS▐" ;; esac
    printf "\r  raising the scaffolding %-4s /%s" "$BARS" "$s"
    sleep 0.15 2>/dev/null || true
done
printf "\r%-60s\r" ""

echo ""
echo "  ▐▐▐▐  ai-scaffold is up — $SCOPE scope ($DEST)"
echo ""
echo "  /as-setup      once per machine: five questions, a profile"
echo "  /as-project    once per repo: goal, stack, levels, curriculum"
echo ""
echo "Start with /as-setup. It speaks your language, literally."
echo ""

# decision-ledger is a runtime dependency, checked here only to say so early;
# /as-setup offers the install and everything works without it.
if ! "$HOME/.claude/skills/decision-ledger/bin/ledger" --version >/dev/null 2>&1; then
    echo "Note: decision-ledger is not installed; structural decisions won't be"
    echo "recorded. /as-setup can install it."
    echo ""
fi
