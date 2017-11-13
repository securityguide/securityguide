---
title: Secrets Management
---

### What is it?

Secrets such as passwords, credentials, access tokens, certificates, and other confidential information are something we can't allow to fall into the wrong hands. A secret management tool makes it possible to manage these kinds of secrets safely.

### Why is it needed?

We see this more than you'd think. The dangers of leaving secrets into your code are wide ranging and severe. It could lead to everything from an attacker compromising a user's session to full owning your application, and even the application server, gaining access to your database, and impersonating you to uncover more valuable data (and this is not an exhaustive list).

* Applications rely on secrets to access services such as databases, encrypted files, and to securely communicate with other applications and systems.
* Team members may also need a way to manage and share similar confidential information.
* Writing secrets in a place they can be easily retrieved exposes projects to unnecessary risks. This includes doing things like writing them on sticky notes or in source code or configuration files.

### Tools

* [[agnostic-secrets-management]]

