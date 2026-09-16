# Acme OS: the shared context folder

This folder holds what the company knows, in a form an AI assistant can read:
what we sell, who our customers are, where each account stands, and how we do
the recurring pieces of work. Point your assistant at it once and it stops
guessing about Acme and starts working from the real thing.

## What is in it

- **Context** - the business, the product, every customer's current status.
- **Skills** - written procedures for work we do repeatedly, so the output comes
  out the same way each time.
- **Routines** - scheduled passes that keep the context current without anyone
  maintaining it by hand.
- **Inputs** - your own email, files and the work tracker.

## Setting it up, once, in about half an hour

1. **Install Google Drive for Desktop.** Install it, open it, click **Open Drive
   folder**, and check that **acme-os** appears under **Shared drives**. The
   first sync can take a few minutes.

2. **Sign in and connect your tools.** Open the assistant's desktop app, sign in
   with your work account, and connect your email, your Drive and the work
   tracker.

3. **Point your workspace at the folder.** Everything loads from there.
   - **Desktop:** choose the working folder, then **Google Drive > Shared drives > acme-os**.
   - **Phone:** open the **Acme OS (mobile)** project. An admin sets that up once.

4. **Schedule your own context update.** *Skip this if you do not deal with
   customers directly.* Paste this in once:

   > Set up a daily task at 9am on weekdays that runs the
   > `ingest-customer-context` routine from the acme-os folder for me, and run
   > it once now.

   The first run asks for access to your email and files. Grant it for those two
   connectors. If you are offered a blanket "always allow everything", do not
   take it: grant the narrowest scope offered that still lets the routine read
   your mail and files, so a future change cannot quietly widen what it reaches.

## Using it: ask in plain language

Open the folder when you work, and ask for what you want:

- *"My role is [your role]. What can this help me with?"*
- *"Draft a solution brief for [customer]."*
- *"Write up this call."*
- *"How is [customer] doing, and what should I be worried about?"*
- *"Which accounts are off track this week?"*

It picks the right procedure and follows it. Anything you make just for
yourself is saved to your own `outputs/` folder, so the shared space stays tidy.

## What it records about you

Worth knowing up front, because you will not otherwise see it.

Every session writes one line, or one empty file, recording **your work email,
your computer's name, the date and time, and which skills you ran**. Anyone on
the team can read those files. The daily admin pass summarises them.

It never records your prompts, the assistant's replies, the contents of any file
you open, or anything you typed. That part is not a policy, it is how the
logging is built: there is nowhere for that information to go.

What it does show is when you worked, including evenings and weekends. If your
admin has switched on the optional per-person summary, it also shows how much
each named person put in and got out.

Two things follow. Your ingest routine reads **your own** mailbox under **your
own** connector, so nobody else's automation reads your mail. And the summaries
it writes into customer folders are readable by everyone here, so write with
that in mind, and tell your admin if something in there should not be.

Questions about any of this go to your Team OS admin. Asking is reasonable.

## Two things that will save you time

**It does about 70 percent.** Every customer-facing document ends with you
reading it properly. The procedure gets you a solid draft; the judgment is
yours.

**It only knows what it has been told.** Step 4 is what keeps your accounts
current, and the folder is worth much more when everyone does it.

---
Acme Corp | acme.example | Confidential
