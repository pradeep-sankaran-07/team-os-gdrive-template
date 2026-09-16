# Mobile: running the Team OS from a phone

The whole OS works on a phone, through a project whose instructions point at the
Shared Drive. People use it a lot and rarely set it up properly, mostly because it is not
obvious that it needs setting up at all.

## Why it needs its own instructions

On a phone the assistant reaches the Drive through the **Google Drive
connector**, not a local folder. That is a genuinely different surface:

- It can **read files and create new ones. That is all.** It cannot edit, move,
  rename or delete an existing file.
- It cannot run code, so it cannot build documents, spreadsheets, slides or
  PDFs, and cannot generate images.
- Skills are not installed. They have to be read from the Drive.
- There is no shell, so there are no hooks. Session logging happens through the
  marker file the rulebook already asks for.

If you say none of this, the assistant will try to edit a file, report that it
saved, and be wrong. That failure is silent and it is the reason this page
exists.

## Setting it up (admin, once, for everyone)

1. Create a project in the assistant, named something like **Acme OS (mobile)**.
2. Connect the Google Drive connector with a work account.
3. Generate the instruction block from
   `.claude/skills/install-team-os/references/mobile-project-template.md` and
   paste it into the project's instructions.
4. Share the project with the team.

Everyone then starts their mobile chats inside that project and gets the whole
OS.

## The principles the instruction block encodes

**Read by file id, never guess one.** The block carries the ids of the handful
of files that must never cost a search: the rulebook, the index, the config, the
status file, the learnings file, and the folder ids needed for listings.

**Say what the surface cannot do, in the instructions.** Never claim an edit
landed. When a task needs one, say plainly that it needs a desktop session, and
offer the replacement text or a new file instead.

**Ship a recovery procedure for stale ids.** An id is stable while a file is
edited in place, but a file that is deleted and recreated gets a new one. When
a read fails, the correct behaviour is to search by name, carry on, and report
the stale entry at the end, never to say the file is missing and never to guess.
With that procedure in the block, a stale id is a minor annoyance rather than a
broken surface, which is why the block does not need constant maintenance.

**Set the content type when creating markdown.** Otherwise Drive silently
converts the file into a Google Doc, and the next reader gets something the rest
of the OS cannot parse.

**Write the session marker here too.** A phone cannot run a hook, so the marker
is the only record that the session happened. It is the same empty file, with
`connector` as the surface.

## What a phone is actually good for

Looking things up, account and product context, answering a customer question
from the knowledge base, drafting an email or a message, writing up a call on
the way back from it, and deciding what a document should say before someone
builds it.

That last use is easy to overlook. The thinking is done on the phone and the
building happens later at a desk, which is a better division of labour than it
sounds.

## Refreshing the block

Regenerate it when a file is deleted and recreated, or once a quarter. If the
recovery procedure is in the block, a stale id degrades gracefully, so this is
maintenance rather than an outage.
