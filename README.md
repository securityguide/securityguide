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

## How to edit pages

See `pages/index.md` for more information.

## TODO

* add the following topics
  * deployment
    * infrastructure as code
    * AWS best practices
      * obtain auth tokens from okta
  * Security Documentation
    * why documentation is important
    * what makes a good network diagram
    * data
      * classification policy
      * lifecycle
      * minimization
    * networks
    * services
    * connections
    * logging and auditing
  * Security Reviews
    * requesting review
    * pre-review questionnaire
    * post-review process
* improve CSS
