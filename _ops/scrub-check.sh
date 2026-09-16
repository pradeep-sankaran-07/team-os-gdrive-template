#!/usr/bin/env bash
# scrub-check.sh - a publication gate for a folder that will be made public.
#
# A Team OS accumulates things that must not leave the company: a client name, a
# brand value, an internal mailing list, a partner under NDA. If you ever publish
# part of this folder, as a template, an example or a talk, this is the check
# that runs first.
#
#   ./_ops/scrub-check.sh          # scan the working tree and the git history
#   ./_ops/scrub-check.sh --list   # show what is being checked, then exit
#
# Exit 0 = clean. Exit 1 = something matched, or the gate could not do its job.
#
# TWO KINDS OF CHECK
#
# 1. Your own terms, read from `_ops/.scrub-terms.local`. That file is
#    gitignored and is never published. This matters more than it looks: a list
#    of terms you are trying to hide is itself a disclosure, because it names
#    each one and asserts that each one is sensitive. Keeping the list out of
#    the published tree is the difference between a gate and a leak. Copy
#    `.scrub-terms.example` to get started.
#
# 2. Shapes of data that are never safe to publish, built in below: Google Drive
#    file and shared-drive ids, common API key prefixes, email addresses outside
#    the reserved example domains, and the em and en dashes this OS bans.
#
# WHAT IT CANNOT DO. It matches text. It cannot see that a paragraph was copied
# from somewhere it should not have been, or that an anecdote is recognisable to
# anyone who was there. A human still has to read the diff.
#
# Portability: the pattern checks run in python3 rather than `grep -P`, because
# BSD grep on macOS has no PCRE support and this has to run anywhere.

set -uo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

TERMS_FILE="_ops/.scrub-terms.local"

load_terms() {
  [[ -f "$TERMS_FILE" ]] || return 0
  # Strip CR (a file saved on Windows would otherwise make every term
  # unmatchable while still looking armed in --list), strip a comment only when
  # the # starts the line or follows whitespace (so a bare hex colour like
  # #D4F0C2 survives as a term), then drop blank lines.
  tr -d '\r' < "$TERMS_FILE" \
    | sed -e 's/[[:space:]]\{1,\}#.*$//' \
          -e 's/^[[:space:]]*#[[:space:]].*$//' \
          -e 's/^[[:space:]]*#[[:space:]]*$//' \
          -e 's/[[:space:]]*$//' -e '/^[[:space:]]*$/d'
}

if [[ "${1:-}" == "--list" ]]; then
  if [[ -f "$TERMS_FILE" ]]; then
    # Masked on purpose. This file argues that a list of hidden terms is itself
    # a disclosure, so it does not print one into a terminal or a CI log.
    n=$(load_terms | wc -l | tr -d ' ')
    echo "literal terms from $TERMS_FILE: $n loaded"
    load_terms | sed 's/\(..\).*/  \1... (\1)/' | awk '{print "  term "NR": "substr($0,3,2)"..."}'
  else
    echo "no $TERMS_FILE - literal-term checking is OFF."
    echo "copy _ops/.scrub-terms.example to $TERMS_FILE to switch it on."
  fi
  cat <<'EOT'
built-in patterns:
  google drive file ids             a long mixed-case token starting with 1
  google shared-drive / legacy ids  a token starting with 0A or 0B
  api key prefixes                  sk-, ghp_, github_pat_, AIza, AKIA, xox
  email addresses off-template      anything not on a reserved example domain
  em dash and en dash               house style bans both
also scanned: the git history (all blobs and commit messages), and filenames.
EOT
  exit 0
fi

fail=0
have_terms=0

if [[ -f "$TERMS_FILE" ]]; then
  have_terms=1
  # `|| [ -n "$t" ]` so a file with no trailing newline does not lose its last term.
  while IFS= read -r t || [ -n "$t" ]; do
    [[ -n "$t" ]] || continue
    if out=$(grep -rIn --exclude-dir=.git --exclude="scrub-check.sh" \
               --exclude=".scrub-terms.local" --exclude=".scrub-terms.example" \
               -i -F -- "$t" . 2>/dev/null); then
      printf 'BANNED TERM in working tree:\n%s\n\n' "$out"
      fail=1
    fi
    # Filenames, not just contents: `oldcompany-notes.md` leaks even when empty.
    if out=$(find . -path ./.git -prune -o -iname "*${t}*" -print 2>/dev/null | grep . ); then
      printf 'BANNED TERM in a filename:\n%s\n\n' "$out"
      fail=1
    fi
    # The git history. A term committed and then removed is still published.
    if [[ -d .git ]]; then
      if out=$(git log --all --format='%H %s%n%b' 2>/dev/null | grep -i -F -- "$t"); then
        printf 'BANNED TERM in a commit message:\n%s\n\n' "$out"
        fail=1
      fi
      if git rev-parse --git-dir >/dev/null 2>&1; then
        # The gate's own files are excluded here for the same reason they are
        # excluded from the working-tree scan: the example terms file contains
        # sample terms, and this script contains the patterns it looks for.
        if out=$(git grep -I -i -F -- "$t" $(git rev-list --all 2>/dev/null) \
                   -- ':(exclude)_ops/scrub-check.sh' ':(exclude)_ops/.scrub-terms.example' \
                   2>/dev/null | head -20); then
          if [[ -n "$out" ]]; then
            printf 'BANNED TERM in git history:\n%s\n\n' "$out"
            fail=1
          fi
        fi
      fi
    fi
  done < <(load_terms)
else
  echo "scrub-check: no $TERMS_FILE, so literal-term checking did NOT run." >&2
fi

python3 - <<'PY' || fail=1
import os, re, sys

SKIP_DIRS = {".git"}
SKIP_FILES = {"scrub-check.sh", ".scrub-terms.local", ".scrub-terms.example"}

# RFC 2606 reserves example.com, .net and .org, plus the .example TLD. All four
# are safe placeholders; anything else is a real address that leaked in.
ALLOWED_EMAIL_SUFFIXES = (
    ".example", "example.com", "example.net", "example.org",
    "users.noreply.github.com",
)

# A real Drive id is a long mixed-case token. Requiring two upper-case letters
# keeps this from firing on ordinary hyphenated slugs and dated filenames.
DRIVE_FILE_ID = re.compile(
    r"(?<![A-Za-z0-9_-])1(?=[A-Za-z0-9_-]{27,})(?:[A-Za-z0-9_-]*[A-Z]){2}[A-Za-z0-9_-]*(?![A-Za-z0-9_-])"
)
# Shared Drive ids start 0A and legacy folder ids 0B, and they are shorter. In a
# template about Shared Drives this is the id most likely to be pasted in.
DRIVE_OTHER_ID = re.compile(r"(?<![A-Za-z0-9_-])0[AB][A-Za-z0-9_-]{15,}(?![A-Za-z0-9_-])")
SECRET = re.compile(r"(?<![A-Za-z0-9_-])(sk-[A-Za-z0-9]{16,}|ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|AIza[A-Za-z0-9_-]{30,}|AKIA[A-Z0-9]{12,}|xox[abprs]-[A-Za-z0-9-]{10,})")
EMAIL = re.compile(r"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}")
DASHES = re.compile(r"[–—]")

# `cowork@markers.csv` and friends are filenames, not addresses.
FILE_EXTENSIONS = (
    ".csv", ".md", ".json", ".sh", ".yaml", ".yml", ".html", ".txt",
    ".png", ".svg", ".gs", ".css", ".js",
)

CHECKS = [
    ("drive file id", DRIVE_FILE_ID),
    ("drive/shared-drive id", DRIVE_OTHER_ID),
    ("api key", SECRET),
    ("off-template email", EMAIL),
    ("em/en dash", DASHES),
]

bad = 0
unscanned = []
for root, dirs, files in os.walk("."):
    dirs[:] = [d for d in dirs if d not in SKIP_DIRS]
    for name in files:
        if name in SKIP_FILES:
            continue
        path = os.path.join(root, name)
        try:
            with open(path, "r", encoding="utf-8") as fh:
                lines = fh.readlines()
        except (UnicodeDecodeError, OSError):
            # Binary or undecodable. A logo PNG can carry the old company name
            # in its metadata, so this is reported rather than passed over.
            unscanned.append(path)
            continue
        for n, line in enumerate(lines, 1):
            for label, rx in CHECKS:
                for m in rx.finditer(line):
                    hit = m.group(0)
                    if label == "off-template email":
                        low = hit.lower()
                        if low.endswith(ALLOWED_EMAIL_SUFFIXES) or low.endswith(FILE_EXTENSIONS):
                            continue
                    print(f"BANNED PATTERN [{label}] {path}:{n}: {hit}")
                    bad += 1

if unscanned:
    print()
    print(f"NOT SCANNED ({len(unscanned)} binary or undecodable files). Check these by hand:")
    for p in unscanned:
        print(f"  {p}")
    print("  Image and Office files can carry a company name in their metadata.")

sys.exit(1 if bad else 0)
PY

if [[ $fail -ne 0 ]]; then
  echo "scrub-check: FAILED - fix the hits above before publishing" >&2
  exit 1
fi

if [[ $have_terms -eq 0 ]]; then
  # Never report a plain "clean" when half the gate did not run. In CI the
  # stderr note above is invisible and a bare exit 0 reads as a pass.
  echo "scrub-check: built-in patterns clean, but NO TERM LIST ran. Not a pass." >&2
  exit 1
fi

echo "scrub-check: clean"
exit 0
