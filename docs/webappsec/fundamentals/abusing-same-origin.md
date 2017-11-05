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
