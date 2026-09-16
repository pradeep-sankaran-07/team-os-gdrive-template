#!/usr/bin/env bash
# sync-agents.sh - generate AGENTS.md from CLAUDE.md.
#
# WHY THIS EXISTS. Two agent tools read two different entry files, and both must
# carry the same operating norms and the same skills routing table. Maintaining
# them by hand does not work. The second copy loses a rule here and a routing row
# there, and because nothing compares them, nobody notices until an agent on that
# side behaves differently and no one can say why. So CLAUDE.md is the single
# source and AGENTS.md is generated.
#
#   ./_ops/sync-agents.sh          # regenerate AGENTS.md
#   ./_ops/sync-agents.sh --check  # exit non-zero if AGENTS.md is stale
#
# HOW A DIFFERENCE IS EXPRESSED. Most of the rulebook is tool-neutral and needs
# no special handling. Where the two genuinely differ, wrap each version in a
# fenced block inside CLAUDE.md. Both fences are HTML comments, so the Codex
# version never renders and never confuses a reader of CLAUDE.md:
#
#     <!-- claude-only -->
#     ...the Claude wording...
#     <!-- /claude-only -->
#     <!-- codex-only
#     ...the Codex wording...
#     -->
#
# Plus one global substitution: `.claude/skills/` becomes `.agents/skills/`.
# Nothing else is substituted. Skills themselves are model-neutral prose and are
# mirrored verbatim, never find-replaced. See sync-skills.sh for why.

set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

SRC=CLAUDE.md
DST=AGENTS.md
MODE="${1:-write}"

render() {
  python3 - "$SRC" <<'PY'
import sys

src = open(sys.argv[1]).read().split("\n")
out, mode = [], None

opened_at = None
errors = []

for n, line in enumerate(src, 1):
    stripped = line.strip()
    if stripped == "<!-- claude-only -->":
        if mode is not None:
            errors.append("line %d: claude-only opened inside a %s block" % (n, mode))
        mode, opened_at = "skip", n
        continue
    if stripped == "<!-- /claude-only -->":
        if mode != "skip":
            errors.append("line %d: /claude-only with no matching opener" % n)
        mode, opened_at = None, None
        continue
    if stripped == "<!-- codex-only":
        if mode is not None:
            errors.append("line %d: codex-only opened inside a %s block" % (n, mode))
        mode, opened_at = "emit", n
        continue
    if mode == "emit" and stripped == "-->":
        mode, opened_at = None, None
        continue
    if mode == "skip":
        continue
    out.append(line)

# An unbalanced fence silently swallows every line up to the next fence. Both
# files come from this same parser, so --check would still say "in sync" while
# whole sections had vanished. A malformed fence is therefore fatal, not a
# warning. This is the failure this script exists to prevent.
if mode is not None:
    errors.append("line %s: %s block opened and never closed" % (opened_at, mode))
if errors:
    sys.stderr.write("sync-agents: malformed fences in CLAUDE.md\n")
    for e in errors:
        sys.stderr.write("  " + e + "\n")
    sys.exit(2)

body = "\n".join(out)
body = body.replace("`.claude/skills/", "`.agents/skills/")

header = (
    "<!-- GENERATED FILE. Do not edit.\n"
    "     Source: CLAUDE.md. Regenerate with ./_ops/sync-agents.sh\n"
    "     Every rule here is the same rule; only the tool-specific paths differ. -->\n"
)
sys.stdout.write(header + body)
PY
}

# Comparing the parser with itself proves determinism, not completeness. This
# additionally asserts that every source line outside a claude-only block
# actually reached the output.
assert_no_loss() {
  python3 - "$SRC" "$DST" <<'NOLOSS'
import sys

src = open(sys.argv[1]).read().split("\n")
dst = set(l.strip() for l in open(sys.argv[2]).read().split("\n"))

skip, missing = False, []
for n, line in enumerate(src, 1):
    st = line.strip()
    if st == "<!-- claude-only -->":
        skip = True
        continue
    if st == "<!-- /claude-only -->":
        skip = False
        continue
    if st in ("<!-- codex-only", "-->"):
        continue
    if skip or not st:
        continue
    # account for the one global substitution this script performs
    if st.replace("`.claude/skills/", "`.agents/skills/") not in dst:
        missing.append("  line %d: %s" % (n, st[:70]))

if missing:
    sys.stderr.write("sync-agents: CONTENT LOSS, these CLAUDE.md lines never reached AGENTS.md\n")
    sys.stderr.write("\n".join(missing[:20]) + "\n")
    sys.exit(1)
NOLOSS
}

if [[ "$MODE" == "--check" ]]; then
  render >/dev/null || exit 1
  assert_no_loss || exit 1
  if ! diff -q <(render) "$DST" >/dev/null 2>&1; then
    echo "sync-agents: DRIFT - $DST does not match $SRC. Run ./_ops/sync-agents.sh" >&2
    diff <(render) "$DST" | head -40 >&2 || true
    exit 1
  fi
  echo "sync-agents: in sync"
  exit 0
fi

tmp=$(mktemp)
render > "$tmp" || { rm -f "$tmp"; exit 1; }
mv "$tmp" "$DST"
assert_no_loss || exit 1
echo "sync-agents: wrote $DST from $SRC"
