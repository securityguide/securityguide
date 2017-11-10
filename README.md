# ThoughtWorks Security Guide

## Directory layout

* security
  * docs: Rendered static pages. For now, these are committed to git so long as we use github pages.
  * pages: The source content for the site.

## Building the static pages

Install prerequisites:

    gem install bundler
    cd security/docs
    bundle

Build the static pages:

    cd security
    make build

To view the pages via a local server:

    cd security
    make serve

## Editing tips

To include a formatted code block:

    {:lang='bash'}
    ~~~
    {% include script.sh %}
    ~~~

## Links

Alternate stylesheets for the Rouge code syntax highlighter: https://github.com/richleland/pygments-css

## TODO

* auto link to page by name
* javascript search https://github.com/christian-fei/Simple-Jekyll-Search
* improve CSS
* autolink urls https://github.com/ivantsepp/jekyll-autolink_email
