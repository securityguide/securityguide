---
title: Agnostic secrets management
toc: true
---

I don't think you need to be scared into not checking secrets in -- you probably already understand that this is bad ([maybe][facepalm commit messages]).

[facepalm commit messages]: https://github.com/search?utf8=%E2%9C%93&q=add+secret+key&type=Commits


# Environment variables

## AWS Parameter Store

https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-paramstore.html

## GoCD

go-env https://docs.gocd.org/15.3.0/faq/dev_use_current_revision_in_build.html

## Heroku

https://devcenter.heroku.com/articles/config-vars


# Encrypted in cloud storage

## cred-stash

Store secrets in AWS using encrypted S3 buckets

https://github.com/fugue/credstash


# Encrypted in source code

## git-crypt

Install

    $ brew install gnupg git-crypt

Initialize in your repo

    $ cd my_project
    $ git crypt init

Specify which files should be encrypted in the `.gitattributes` file:

    *.key filter=git-crypt diff=git-crypt

Add public keys that can decrypt the files:

    $ git-crypt add-gpg-user USER_ID

After cloning a repository with encrypted files, unlock with:

    $ git-crypt unlock

Check which files are encrypted:

    $ git crypt status

# Further reading

https://12factor.net/config
