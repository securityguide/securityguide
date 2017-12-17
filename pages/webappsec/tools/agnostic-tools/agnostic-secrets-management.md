---
title: Agnostic secrets management
toc: true
---

I don't think you need to be scared into not checking secrets in -- you probably already understand that this is bad ([maybe][facepalm commit messages]). Just in case, here is a handy rule: never commit cleartext secrets of any kind to git, no matter what.

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

<https://github.com/fugue/credstash>

## Vault

<https://www.vaultproject.io/>

# Encrypted in source code

## git-crypt

With `git-crypt`, you can store files in git that are automatically encrypted using GnuPG.

Install

    $ brew install gnupg git-crypt

Initialize in your repo

    $ cd my_project
    $ git crypt init

Add public keys that can decrypt the files:

    $ git-crypt add-gpg-user USER_ID

Specify which files should be encrypted in the `.gitattributes` file:

    *.key filter=git-crypt diff=git-crypt

After cloning a repository with encrypted files, unlock with:

    $ git-crypt unlock

Check which files are encrypted:

    $ git crypt status

## BlackBox

<https://github.com/StackExchange/blackbox>

Like git-crypt, blackbox helps you store secrets in git using GnuPG. Blackbox will also with any source control, not just git.

With BlackBox, however, nothing is automatic. If you want to edit a file, you must decrypt it first. In contrast, git-crypt is automatic, which can be weird and confusing. The BlackBox approach can be more comforting and safe, because you never commit what appears to be a cleartext file. But the manual approach can also be painfully laborious.

Install

    $ brew install blackbox

Initialize in your repo:

    $ cd my_project
    $ blackbox_initialize

Add public keys that can decrypt the files:

    $ blackbox_addadmin coworker@thoughtworks.com

Specify what files should be encrypted:

    $ blackbox_register_new_file path/to/file.name.key

Unlock, edit, lock, commit:

    $ blackbox_edit_start FILENAME
    ... edit file ...
    $ blackbox_edit_end FILENAME
    $ git commit ...

# Further reading

https://12factor.net/config
