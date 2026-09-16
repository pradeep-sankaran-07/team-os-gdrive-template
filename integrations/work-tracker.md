# Work tracker (live over MCP)

**Demo content.** `config.yaml` `work_tracker` holds the real values. This file
is the pattern for documenting a live system so an assistant can use it without
guessing.

## Connection

Reached over MCP, at the URL in `config.yaml` `work_tracker.mcp_url`. Nothing
here is hardcoded. Support tickets are reached **through** the tracker rather
than as a separate connection, so there is one place to look.

## The object model

Initiatives contain projects; projects contain issues. Teams own work; cycles
are time boxes. An issue belongs to exactly one team and at most one project.
Knowing this ordering is what stops an assistant querying issues when it wanted
projects.

## What to ask it for

| Question | Where the answer is |
|---|---|
| What is shipping this quarter | projects, filtered by cycle |
| Why is this customer blocked | issues carrying that customer's label |
| What is the team working on now | the current cycle for that team |
| Is this specified | the project description, then `product/prds/` |

## Things that will trip you up

- An issue can sit in a project whose team is not the team the issue belongs to.
  Filter on the one you actually mean.
- Closed and cancelled are different states and mean very different things to a
  customer waiting on something.
- Labels are how customers are attached to issues. A customer with no label is
  invisible to every query, which usually means the label was never applied
  rather than that nothing is blocked.

## Rule

**Query live, never mirror.** Do not create files in this repo that copy tracker
content. A roadmap or a status copied into Markdown is stale within days, and
then there are two answers to the same question and no way to tell which is
current. `product/roadmap.md` holds only the shaping decisions a ticket would
lose.
