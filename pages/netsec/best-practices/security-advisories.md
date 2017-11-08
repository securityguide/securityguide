---
title: Security Advisories
---

### Step 1 - Create a Patch Management List

First, create a list of all the major software that your systems rely on but that are not checked automatically using a dependency checker in a test pipeline. For example, you do not need to add libraries that a web application depends on to your patch management list, but you should add the operating system, the web server, the database server, and so on.

### Step 2 - Identify notification sources

For every item in your list, write down the URL for where you can find canonical vulnerability information. All major software projects will offer this. Often, you can also subscribe to a mailing list.

Alternately, there are commercial services that will handle this patch management notification for you.

### Step 3 - Set the date

Pick a day on the calender where you will check every URL on your list to see if there are any new vulnerabilities listed since the last time you checked.
