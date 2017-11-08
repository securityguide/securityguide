---
title: Other Tricks
---

# Referrers

There are several things you can do to try to prevent the browser from sending referers

   * Add the attribute rel="noreferrer" to links. This only protects links, and is not universally supported by browsers.

   * Replace links with Data URIs that reload to the new URL, hiding the referer. This only protects links. For example:

    <a href="data:text/html,<meta http-equiv='refresh' content='0; url=https://example.org'>">example.org</a>

   * Add a Content Security Policy (v1.1 or later) with a restrictive referer directive. This does not work in all browsers.

   These are all good ideas for increasing the user's privacy, but should not be relied on to mitigate the problems associated with sensitive information in the URL.

# Same Origin

  * Abusing same origin policy
    * how it works
    * how it falls down
      * CSRF
        * different origin writes allowed
        * tags for: forms, images, assets are allowed
      * dns rebinding
    * best pratices

* javascript can only phone home
* CORS can allow scripts to violate the same origin policy
* every javascript that is loaded can read (most) everything on the page and send the information back to its origin.
* javascript cannot read 'tainted' assets that have been loaded dynamically from different domains.
