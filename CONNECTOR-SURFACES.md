# Connector surfaces and what each one can do

Not everyone reaches this folder the same way. Some people have it mounted as a
local folder; others reach it through a Google Drive connector, on a phone or in
a project on a laptop. Those are different surfaces with different limits, and
the limits are not the same across AI products.

This page is about the **access method**, not the device. A phone always uses a
connector, but a connector does not mean a phone: someone running a project on a
desktop hits exactly the same constraints.

## The two things that vary

**Editing.** A connector can normally read files and create new ones. It cannot
edit, move, rename or delete an existing file. A mounted folder can do all of it.

**What it can create.** This is the one that catches people out, because it
varies by product. Some connectors create ordinary files, including `.md`.
Others create only native Google Docs, Sheets and Slides, which means they
cannot write a Markdown file at all.

The second one fails quietly. Reading works either way, so the project looks
healthy, and nobody finds out until they go looking for a file that was never
written. Two things break when a surface cannot create a `.md`:

- Nothing drafted there is ever filed. A call written up on the phone has to be
  copied back by hand from a desktop session.
- No session marker is written, so that surface never appears in the adoption
  count. See `_ops/sessions/markers/README.md`.

## Find out, do not assume

Do this once per product, during install, and record the answer in the table
below. It takes a minute and it is the only version of this page that stays
true, because these capabilities change.

> Create one empty file called `probe.md` in `_ops/sessions/markers/`.

Three possible outcomes:

| What happens | What that surface is |
|---|---|
| The file is created as `probe.md` | a writing surface. Use the full instruction block |
| It is created, but as a Google Doc | a read surface. Delete the Doc and use the read block |
| It says it cannot create the file | a read surface. Use the read block |

Then delete the probe file and fill this in:

| Product | Reads the OS | Creates `.md` | Block to use |
|---|---|---|---|
| _your product_ | | | |
| _your other product_ | | | |

## The two instruction blocks

Generate both from
`.claude/skills/install-team-os/references/mobile-project-template.md`.

**The write block** is the full one. It reads by file id, writes a session
marker, and files new notes into account folders.

**The read block** is for a surface that cannot create a `.md` file. It creates
nothing at all. When someone drafts something on it, it hands the text back in
the reply and names the folder the person should save it into from a desktop
session. It does not write a session marker, and it does not pretend to.

Do not give a read surface the write block. It will try, report success, and be
wrong.

## Setting it up (admin, once, for everyone)

1. Create a project in each AI product the team uses, named for this OS.
2. Connect the Google Drive connector with a work account.
3. Run the probe above.
4. Paste in the matching block.
5. Share the project with the team.

## What the write block encodes

**Read by file id, never guess one.** The block carries the ids of the handful
of files that must never cost a search: the rulebook, the index, the config, the
status file, the learnings file, and the folder ids needed for listings.

**Say what the surface cannot do, in the instructions.** Never claim an edit
landed. When a task needs one, say plainly that it needs a desktop session, and
offer the replacement text or a new file instead.

**Ship a recovery procedure for stale ids.** An id is stable while a file is
edited in place, but a file that is deleted and recreated gets a new one. When a
read fails, the correct behaviour is to search by name, carry on, and report the
stale entry at the end, never to say the file is missing and never to guess.
With that procedure in the block, a stale id is a minor annoyance rather than a
broken surface.

**Set the content type when creating markdown.** Otherwise Drive silently
converts the file into a Google Doc, and the next reader gets something the rest
of the OS cannot parse. On some products this is not a setting you can reach,
which is exactly what the probe is for.

**Write the session marker.** A connector cannot run a hook, so the marker is
the only record that the session happened.

## What a connector surface is good for

Looking things up, account and product context, answering a question from the
knowledge base, drafting an email or a message, writing up a call on the way
back from it, and deciding what a document should say before someone builds it.

That last use is easy to overlook. The thinking is done away from the desk and
the building happens later, which is a better division of labour than it sounds.

## Refreshing it

Re-run the probe when you add a product, and once a quarter. Regenerate the id
block when a file is deleted and recreated. If the recovery procedure is in the
block, a stale id degrades gracefully, so this is maintenance rather than an
outage.
