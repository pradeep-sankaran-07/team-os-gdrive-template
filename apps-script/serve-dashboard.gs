/**
 * serve-dashboard.gs
 *
 * Serves a generated HTML file that lives in this Drive folder at a stable
 * internal URL.
 *
 * THE PROBLEM. The customer dashboard is a single self-contained HTML file in
 * the Shared Drive. Opening it from a synced Drive folder works, but that path
 * contains the opener's own account, so it cannot be shared. And Google Drive's
 * web preview does not execute JavaScript, so a plain Drive link renders a
 * blank page. Anyone without the desktop mount is stuck.
 *
 * THE FIX. A Web App that reads the file fresh on every request and returns it
 * as HTML. No git, no hosting, no bill.
 *
 * READ THIS BEFORE DEPLOYING. A Web App deployed as "execute as me" bypasses
 * the Drive permissions entirely: whoever can open the URL sees the file, with
 * the deployer's access, whether or not they are on the Shared Drive. This
 * dashboard contains per-customer commercial values.
 *
 *   - Set access to a NAMED GROUP, the one in config.yaml
 *     `customer_dashboard.apps_script.audience_group`.
 *   - Do NOT set it to "anyone within the organisation". That hands per-customer
 *     values to every account in your Workspace, including contractors,
 *     interns and anyone who was deliberately left off the Shared Drive.
 *   - Never set it to "anyone with the link".
 *
 * DEPLOYMENT
 *   1. script.google.com, new project, paste this in.
 *   2. Set FILE_ID from config.yaml `customer_dashboard.apps_script.file_id`.
 *   3. Deploy > New deployment > Web app.
 *        Execute as:     Me (the owner)
 *        Who has access: the named group above, never the whole organisation
 *   4. Record the /exec URL in config.yaml `…apps_script.live_url`.
 *   5. Have a second person confirm they can open it, and a third person who is
 *      NOT in the group confirm they cannot.
 *
 * Step 5 is the deployment test. An access setting that is wider than intended
 * looks identical to a correct one from the deployer's own browser.
 *
 * CONTENT CHANGES NEED NO REDEPLOY. The script reads the file on every request,
 * so rebuilding the dashboard is enough. Only editing this script needs a new
 * deployment version.
 *
 * Record the deployment state here, so the next admin does not have to hunt:
 *   project:  <name>
 *   live URL: <the /exec url>
 *   audience: <the group>
 *   version:  <n>, deployed <date> by <who>
 */

var FILE_ID = 'PLACEHOLDER_dashboard_file_id';
var TITLE = 'Customer dashboard';

function escapeHtml_(s) {
  return String(s)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function doGet() {
  try {
    var html = DriveApp.getFileById(FILE_ID).getBlob().getDataAsString('UTF-8');
    // No ALLOWALL. The default framing policy stays on: this page is an
    // authenticated internal dashboard, and letting any site embed it invites
    // clickjacking against whoever is signed in.
    return HtmlService.createHtmlOutput(html).setTitle(TITLE);
  } catch (err) {
    // Render the reason rather than throwing, so the person who opened the link
    // sees something they can act on. The error is escaped: it can contain a
    // filename, and an unescaped error message is a reflected-XSS sink.
    return HtmlService.createHtmlOutput(
      '<h2>Dashboard unavailable</h2>' +
      '<p>Could not read the dashboard file. The usual cause is that FILE_ID is ' +
      'wrong, or the account this script runs as has lost access to the file.</p>' +
      '<pre>' + escapeHtml_(err) + '</pre>'
    ).setTitle(TITLE);
  }
}
