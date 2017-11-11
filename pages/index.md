---
title: ThoughtWorks Security Guide
nav_title: Home
---

## Contents

**[WebAppSec](webappsec)** Writing and maintaining secure web applications.

**[NetSec](netsec)** Best practices for secure infrastructure development and deployment best.

**[OpSec](opsec)** How to prevent attacks against your devices and your data.

## Contributing

#### Editing tips

**Syntax**

These pages use Markdown syntax ([Kramdown flavored](https://kramdown.gettalong.org/quickref.html)).

**Wiki links**

In addition to traditional Markdown syntax for links, you can use wiki-style links, like so:

    \[[page_name]]
    \[[page_name|Title]]
    \[[Title => page_name]]

Using wiki-style links is highly preferred, because these links will not break when a page moves and missing links will produce an error notice.

**Includes**

You can mix in [Liquid tags](https://jekyllrb.com/docs/templates/) in your Markdown pages. For example, this text:

> &#123;% include blah.md %&#125;

Will insert the contents of `pages/_includes/blah.md` into the current page.

To include a formatted code block:

> &#96;&#96;&#96;bash<br>
> &#123;% include script.sh %&#125;<br>
> &#96;&#96;&#96;

#### Simple method: editing on Github

Learning to use git can be very difficult. As an alternative, it is possible
to contribute to `security.git` by directly editing pages through the Github
website. This method does not let you preview how the page will render, but it
does allow you to contribute edits without needing to install any software.

First, you need to register a github.com account. Then visit
[github.com/thoughtworks/security](https://github.com/thoughtworks/security).

To edit files:

* **Existing Files:** You can edit an existing file by clicking on the file
  name and then clicking the "Edit" button in the file's toolbar (it looks like
  pencil). To save, type a commit message and hit the "Propose file change" button.
* **New Files:** You can add a new page by clicking the "+" button at the
  end of the path breadcrumbs (e.g. "security / pages / netsec / [+]"
  near the top of the page). When you are done editing the content, hit the
  "Propose new file" button.

Boom, you are done. Someone will review the change request
and either merge it right away or add comments.

#### Advanced method: using git and Jekyll

**Clone the repository**

1. Fork the [project repository](https://github.com/thoughtworks/security)
   by clicking on the 'Fork' button near the top right of the page. This creates
   a copy of the code under your GitHub user account. For more details on
   how to fork a repository see [this guide](https://help.github.com/articles/fork-a-repo/).

2. Clone your fork of the `security` repo from your GitHub account to your local disk:

   ```bash
   $ git clone git@github.com:YOUR_GITHUB_LOGIN/security.git
   $ cd security
   ```

3. Create a ``feature`` branch to hold your development changes:

   ```bash
   $ git checkout -b my-feature
   ```

4. Modify the pages in your feature branch. Add changed files using ``git add`` and then ``git commit`` files:

   ```bash
   $ git add modified_files
   $ git commit
   ```

   Then push the changes to your GitHub account with:

   ```bash
   $ git push -u origin my-feature
   ```

5. Issue a pull request

Go to https://github.com/YOUR_GITHUB_LOGIN/security and push the button to [issue a pull request](https://help.github.com/articles/using-pull-requests). Someone will review your changes and merge them or comment on them.

**Installing Jekyll**

In order to preview your edits before you commit them, you will need a program called `jekyll`.

Install `bundler` for Mac:

    $ brew install ruby
    $ gem install bundler

Install `bundler` on Debian/Ubuntu:

    # apt install ruby ruby-dev build-essential
    # gem install bundler

Install `jekyll`:

    $ cd security
    $ bundle

**Previewing pages**

When you are making changes, you can prevew the changes by running the jekyll server:

    $ cd security
    $ make serve

Then browse to [http://localhost:4000](http://localhost:4000). Any page you view this way gets re-rendered when it is loaded.

After you have made changes, run this command to completely render the static HTML for the entire site:

    $ cd security
    $ make build

**Putting it all together**

1. Go to https://github.com/thoughtworks/security and click the fork button.
2. Clone your fork locally: `git clone ssh://git@github.com/YOUR_GITHUB_LOGIN/security`
3. Start the amber server: `cd security; make serve`
4. Edit files in `security/pages`
5. Preview changes in your browser using http://localhost:4000
6. When satisfied, `git commit`, `git push`
7. Go to https://github.com/YOUR_GITHUB_LOGIN/security and push the button to [issue a pull request](https://help.github.com/articles/using-pull-requests).

**Keeping up to date**

After a while, your fork of the repo will become out of date. In order to refresh it with the lastest upstream content:

    $ git remote add upstream https://github.com/thoughtworks/security
    $ git checkout master
    $ git fetch upstream
    $ git rebase upstream/master

