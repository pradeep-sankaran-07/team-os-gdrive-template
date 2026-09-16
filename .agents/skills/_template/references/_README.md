# references/

Longer material this skill loads on demand: worked examples, lookup tables,
detailed rules that would bloat SKILL.md.

Point at a file by name from a step in SKILL.md. Do not paste its content into
SKILL.md, and do not write a reference nobody points at.

Relative links must resolve from both `.claude/skills/<name>/` and
`.agents/skills/<name>/`, because the skill is mirrored into both. Both trees
are the same depth, so a plain relative path works. The promotion gate checks it.
