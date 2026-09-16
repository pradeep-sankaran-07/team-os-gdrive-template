#!/usr/bin/env bash
# log-session.sh - the Team OS adoption metric.
#
# Answers three questions per person: WHO they are, HOW MANY sessions they run,
# and WHAT KIND of work they do here, so the team can see who is getting value
# and who is quietly stuck.
#
# Fired by two hooks (see .claude/settings.json and .codex/hooks.json):
#   SessionStart        -> one "session" row (who + when)
#   PreToolUse [Skill]  -> one "skill"   row (which skill was run)
# Every other tool is ignored. Nothing else is logged.
#
# PRIVACY BY CONSTRUCTION. Metadata only. It never records prompts, responses,
# file contents, file paths, session titles, or any customer data. `detail` is
# only ever a fixed keyword (startup/resume) or a skill name. There is nothing
# confidential in the log, so nothing ever needs redacting.
#
# CONFLICT-FREE ON A SYNCED DRIVE. Each machine appends to its OWN file,
# _ops/sessions/<user>@<host>.csv, so two people working at once never collide.
# Aggregate by reading them all; the readers glob _ops/sessions/*@*.csv.
#
# ACCESS CANARY. _ops/ is writable by the whole team, so a successful row here
# also proves that person's grant is effective. If the write fails (a Viewer, or
# a read-only mount) we fall back to outputs/_health/, which is always writable,
# and record a write-blocked row. That row is the only signal that positively
# means someone's access is broken. The daily routine reads both.
#
# It must never interfere with a session: it tolerates every error and always
# exits 0.

# If fd 0 is closed, point it at /dev/null BEFORE the command substitution
# below. Otherwise bash hands the substitution's own pipe to fd 0, cat reads a
# pipe it is itself holding open, and the hook hangs forever. That would stall
# every session start on any runner that does not set a hook timeout.
[ -e /dev/fd/0 ] || exec 0</dev/null

input=$(cat 2>/dev/null || true)

proj="${CLAUDE_PROJECT_DIR:-$PWD}"
dir="$proj/_ops/sessions"

# --- best-effort JSON field reader. No content is ever extracted. ---
jf() { # jf <key> [<subkey>] : print a top-level (or one-deep) string value
  command -v python3 >/dev/null 2>&1 || { echo ""; return; }
  # If python3 is missing every field comes back empty and this hook becomes a
  # silent no-op, which reads downstream as "this person never used the OS".
  # That is the exact misreading this file exists to prevent, so it leaves a
  # canary instead. See the no_python guard below.
  printf '%s' "$input" | python3 -c '
import sys, json
try:
    d = json.load(sys.stdin)
except Exception:
    print(""); raise SystemExit
keys = sys.argv[1:]
for k in keys:
    if not isinstance(d, dict):
        print(""); raise SystemExit
    d = d.get(k, "")
print(d if isinstance(d, str) else "")
' "$@" 2>/dev/null || echo ""
}

if ! command -v python3 >/dev/null 2>&1; then
  proj_fallback="${CLAUDE_PROJECT_DIR:-$PWD}"
  ts=$(date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || echo unknown)
  uh="${USER:-unknown}@$(hostname -s 2>/dev/null || echo unknown)"
  { mkdir -p "$proj_fallback/outputs/_health"; } 2>/dev/null || exit 0
  f="$proj_fallback/outputs/_health/$uh.csv"
  [ -s "$f" ] || { printf '%s\n' "ts_utc,event,detail,drive_account,person,user_host,session_id" >> "$f"; } 2>/dev/null
  { printf '%s\n' "$ts,logger-disabled,no-python3,unknown,unknown,$uh," >> "$f"; } 2>/dev/null
  exit 0
fi

event_name=$(jf hook_event_name)
session_id=$(jf session_id)

case "$event_name" in
  SessionStart)
    event="session"
    detail=$(jf source)
    [ -n "$detail" ] || detail="startup"
    ;;
  PreToolUse)
    # Only the Skill tool is of interest. Everything else exits silently.
    [ "$(jf tool_name)" = "Skill" ] || exit 0
    event="skill"
    detail=$(jf tool_input skill)
    [ -n "$detail" ] || detail="unknown"
    ;;
  *)
    exit 0
    ;;
esac

# --- identity, derived from the session, never from a roster ---
# The Drive for Desktop mount path contains the person's work account, which is
# the only reliable "who" available to a shell hook.
drive_account=$(printf '%s' "$proj" | sed -n 's#.*GoogleDrive-\([^/]*\)/.*#\1#p')
[ -n "$drive_account" ] || drive_account="unknown"
person=$(id -F 2>/dev/null || echo "${USER:-unknown}")
user_host="${USER:-unknown}@$(hostname -s 2>/dev/null || echo unknown)"
ts_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)

# Strip the separators that would forge a row, then defuse the leading
# characters that make a spreadsheet treat a cell as a formula. `detail` comes
# from model-controlled input, so a crafted skill name could otherwise land a
# clickable =HYPERLINK(...) in a file the whole team opens in Sheets.
csv_escape() {
  printf '%s' "$1" | tr -d '\r\n' | sed -e 's/,/ /g' -e 's/^[=+@-]/ &/' -e 's/^\t/ /'
}
row="$(csv_escape "$ts_utc"),$(csv_escape "$event"),$(csv_escape "$detail"),$(csv_escape "$drive_account"),$(csv_escape "$person"),$(csv_escape "$user_host"),$(csv_escape "$session_id")"
header="ts_utc,event,detail,drive_account,person,user_host,session_id"

write_row() { # write_row <target-file> <row>
  local f="$1" r="$2" d
  d=$(dirname "$f")
  # Braces around the redirection, not just the command: a failing `>>` is
  # reported by the shell itself, so `cmd >> f 2>/dev/null` still prints. This
  # hook must stay completely silent on a read-only mount.
  { mkdir -p "$d"; } 2>/dev/null || return 1
  if [ ! -s "$f" ]; then
    { printf '%s\n' "$header" >> "$f"; } 2>/dev/null || return 1
  fi
  { printf '%s\n' "$r" >> "$f"; } 2>/dev/null || return 1
  return 0
}

if ! write_row "$dir/$user_host.csv" "$row"; then
  # Access canary: _ops/ is not writable for this person. Record the fact where
  # they can always write, so the daily digest surfaces the broken grant.
  blocked="${row/,$event,/,write-blocked,}"
  write_row "$proj/outputs/_health/$user_host.csv" "$blocked" || true
fi

exit 0
