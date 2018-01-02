---
title: Abusing URLs
---

## Referrers

When a user clicks on a link on a web page, the browser sends the original URL to the new page that it opens. This original URL is called the HTTP referrer (originally misspelled 'referer'). The browser will also send the referrer for other requests triggered by the page, such as images and stylesheets.

This is a big problem if there is anything sensitive in the URL, such as a session ID or access key. For this reason, it is important to try to not ever put anything sensitive in the URL.

There are several attacks that can take advantage of referrers to exfiltrate any sensitive information in the URL. For example, "Relative Path Overwrite".

To try to prevent the browser from sending referers:

* Add the attribute rel="noreferrer" to links. This only protects links, and is not universally supported by browsers.
* Replace links with Data URIs that reload to the new URL, hiding the referer. This only protects links. For example:
```
<a href="data:text/html,<meta http-equiv='refresh' content='0; url=https://example.org'>">example.org</a>
```
* Add a Content Security Policy (v1.1 or later) with a restrictive referer directive. This does not work in all browsers.

These are all good ideas for increasing the user's privacy, but should not be relied on to mitigate the problems associated with sensitive information in the URL.

## Same Origin

* javascript can only phone home
* Abusing same origin policy
  * how it works
  * how it falls down
    * CSRF
      * different origin writes allowed
      * tags for: forms, images, assets are allowed
    * dns rebinding
  * best pratices
* CORS can allow scripts to violate the same origin policy
* what javascript can read
  * every javascript that is loaded can read (most) everything on the page and send the information back to its origin.
  * javascript cannot read 'tainted' assets that have been loaded dynamically from different domains.
