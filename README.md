# ThoughtWorks Security Guide

## Directory layout

* securityguide
  * pages: The source content for the site.
  * docs: Rendered static pages. These are NOT committed to this repo. Instead, these
    rendered files are committed to `securityguide.github.io.git`.

## Building the static pages

Install prerequisites:

    brew install git
    brew install ruby
    git clone ssh://git@github.com/securityguide/securityguide
    cd securityguide
    gem install bundler
    bundle

Build the static pages:

    cd securityguide
    make build

To view the pages via a local server:

    cd securityguide
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
