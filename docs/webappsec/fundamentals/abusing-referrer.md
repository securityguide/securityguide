There are several things you can do to try to prevent the browser from sending referers

   * Add the attribute rel="noreferrer" to links. This only protects links, and is not universally supported by browsers.

   * Replace links with Data URIs that reload to the new URL, hiding the referer. This only protects links. For example:

    <a href="data:text/html,<meta http-equiv='refresh' content='0; url=https://example.org'>">example.org</a>

   * Add a Content Security Policy (v1.1 or later) with a restrictive referer directive. This does not work in all browsers.

   These are all good ideas for increasing the user's privacy, but should not be relied on to mitigate the problems associated with sensitive information in the URL.
