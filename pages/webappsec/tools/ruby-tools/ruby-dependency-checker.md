---
title: Dependency check for Ruby
---

## bundler-audit

The `bundler-audit` command will examine your `Gemfile.lock` to check for vulnerable versions of gems.

### Installation

    $ gem install bundler-audit

### Usage

    $ bundle-audit update
    $ bundle-audit check

For use in a pipeline, you can combine `update` and `check` together like so: `$ bundle-audit check --verbose --update`. The `--verbose` option will print out additional information about the identified vulnerability.

### Run in your pipeline

Ideally, dependency checkers should be integrated into your CI pipeline. Think of this as a test (a security test) that will run as your others do and fail if either:

* You have vulnerable dependencies
* Updating your vulnerable dependencies causes another issue

This will, of course, depend on your configuration and what works best for your team.

For example, in `.gitlab-ci.yml`:

```yaml
stages:
  - build
  - checks
  - test
  - deploy

bundle_audit:
  stage: checks
  script: |
    gem install bundler-audit
    bundle-audit check --update
...
```

### Run in pre-commit

If your team uses a pre-commit script, you could run a `bundler-audit` check as part of that script.

Keep in mind that, if you will be using the update option, it's probably a good idea to:

1. run your tests
2. run `bundle-audit --update`
3. run your tests again so that you can definitively tell if the update is what broke your tests.
