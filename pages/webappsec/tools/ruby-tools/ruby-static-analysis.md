---
title: Static analysis for Ruby
toc: true
---

## Brakeman

Brakeman is a great and free static analysis tool for Rails. It does not catch all vulnerabilities, but it contains a wealth of knowledge regarding best practices.

One great aspect of brakeman is that, not only does it scan your code and alert you to potential security bugs, but it also provides extensive documentation to help you understand the dangers of each vulnerability.

### Installation

    $ gem install brakeman

### Usage

    $ brakeman my-project/

You can specify the Rails version with `-4` or `-5`.

My personal favorite way to run Brakeman if I've got time:

    $ brakeman my-project/ -A -f html -o brakeman-report-DATE.html

My personal favorite way to run Brakeman if I've already run a few scans:

    $ brakeman my-project/ --faster -confidence-level 2 -f html -o brakeman-report-DATE.html

Checkout further documentation on Brakeman options [here][brakeman_link].

[brakeman_link]:http://brakemanscanner.org/docs/options/

### Run in your pipeline

For example, in `.gitlab-ci.yml`:

```yaml
stages:
  - build
  - checks
  - test
  - deploy

brakeman:
  stage: checks
  script: |
    gem install brakeman
    brakeman
...
```

## Dawnscanner

Dawnscanner is a source code security analysis tool that is compatible with __Rails, Sinatra, and Padrino__.

### Installation

$ gem install dawnscanner

Alternately, you can verify the gem's signature. To be sure the gem you install hasn’t been tampered with, first add paolo@dawnscanner.org public signing certificate as trusted to your gem specific keyring.

    $ gem cert --add <(curl -Ls https://raw.githubusercontent.com/thesp0nge/dawnscanner/master/certs/paolo_at_dawnscanner_dot_org.pem)
    $ gem install dawnscanner -P MediumSecurity

## Rubocop

Rubocop is source code analysis tool, primarily designed to "lint" your code. It is not specifically meant for finding security bugs, but can be configured to be useful for this purpose.

One benefit of Rubocop is that it can act as your linter as well as provide some light security analysis. If you are using a framework like Rails or Sinatra, Brakeman or Dawnscanner (respectively) are probably better bets for security-specific analysis.

That being said, Rubocop is highly configurable, and has [extensive documentation](https://rubocop.readthedocs.io/en/latest/). You can pick and choose which rules (aka cops) to use, and you can even write your own.

### Installation

    $ gem install rubocop

For more details, see the [rubucop documentation](https://rubocop.readthedocs.io/en/latest/installation/)).

### Usage

Analyzing your files with Rubocop is as simple as running

    $ cd my_project
    $ rubocop

Of course, there are some fancier options as well. Some particularly interesting ones for security purposes are:

`--except`  Allows you to exclude particular cops or departments (the general category that cops reside in, i.e. Department = Layout, cops = SpaceBeforeComma, TrailingWhitespace, etc.)

`--only`  The opposite of the except option

`-D/--display-cop-names`  This will include the cop names in the output so you can see which cops are particularly useful and/or noisy. This might help you figure out which to use with `--except` and `--only`.

Of course, you can find all of the other available options in the usual ways.

### Configuration

You can customize the config file, and even specify mulitple config files at runtime.

You can also specify `inherit_from` in your .rubocop.yml config file. You can inherit from other files in your project, as well as a remote URL.

