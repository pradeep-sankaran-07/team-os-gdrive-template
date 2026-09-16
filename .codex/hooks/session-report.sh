#!/usr/bin/env bash
# session-report.sh - read the adoption metric. No arguments, runs from anywhere.
#
# Reads every _ops/sessions/*@*.csv. The `@` in every filename is required, not
# decorative: per-machine hook files are named <user>@<host>.csv and the Cowork
# marker rollup is named cowork@markers.csv, so one glob picks up both.
#
# This is the ad-hoc reader. The daily admin routine produces the fuller
# picture, including the people this file cannot see: someone who only READS the
# OS leaves no trace any of these counts can find, so a low number here means
# "wrote little", never "got no value".

set -uo pipefail
# This script lives in .claude/hooks/, two levels below the repo root. Resolve
# symlinks first, or invoking it through one lands somewhere else entirely and
# it reports "no data" instead of failing.
src="${BASH_SOURCE[0]}"
while [ -L "$src" ]; do src="$(readlink "$src")"; done
cd "$(dirname "$src")/../.." || { echo "session-report: cannot find the repo root" >&2; exit 1; }

# compgen rather than indexing files[0], which is unbound under `set -u` when
# the caller has nullglob set.
if ! compgen -G "_ops/sessions/*@*.csv" > /dev/null; then
  echo "No session data yet. Expected _ops/sessions/<user>@<host>.csv (hooks) or cowork@markers.csv (marker rollup)."
  exit 0
fi

read_all() { cat _ops/sessions/*@*.csv 2>/dev/null | grep -v '^ts_utc,'; }

echo "== Sessions per person (all time) =="
read_all | awk -F, 'NF==7 && $2=="session" && $4!=""{print $4}' | sort | uniq -c | sort -rn

echo
echo "== Sessions per person (last 7 days) =="
# BSD then GNU. If neither works, say so rather than silently reporting all time.
cutoff=$(date -u -v-7d +%Y-%m-%d 2>/dev/null || date -u -d '7 days ago' +%Y-%m-%d 2>/dev/null || echo "")
if [ -z "$cutoff" ]; then
  echo "  (cannot compute a 7-day cutoff on this system; skipped)"
else
read_all | awk -F, -v c="$cutoff" 'NF==7 && $2=="session" && $4!="" && substr($1,1,10) >= c {print $4}' | sort | uniq -c | sort -rn

fi

echo
echo "== What kind of work, per person (skill runs) =="
read_all | awk -F, 'NF==7 && $2=="skill" && $4!=""{print $4"  ->  "$3}' | sort | uniq -c | sort -rn

echo
echo "== Most recent session per person =="
read_all | awk -F, 'NF==7 && $2=="session" && $4!=""{ if ($1 > last[$4]) last[$4]=$1 } END { for (p in last) printf "  %-40s %s\n", p, last[p] }' | sort

echo
echo "== Access blocked (their mount cannot write to _ops/) =="
if compgen -G "outputs/_health/*.csv" > /dev/null; then
  cat outputs/_health/*.csv 2>/dev/null | awk -F, '$2=="write-blocked"{print "  "$4"  "$6}' | sort -u
else
  echo "  none"
fi
