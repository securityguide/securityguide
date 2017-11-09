---
title: Generic Pre-flight Checklist
nav_title: Generic
toc: true
---

## Configuration

### TLS is required in production
### Secrets are stored in the environment

### Anti-CSRF is enabled

When a web browser submits a HTTP request, it dutifully includes all matching cookies, regardless of what web page the request came from. Without CSRF protection, a nefarious page can get your browser to make requests to a protected site while authenticated as you.

Remember:

* Idempotent HTTP GET: You must remember to make all GET actions idempotent (does not change the data). This is because the Rails anti-CSRF only applies to HTTP POST.
* Images are not protected: Images and other assets are not protected by the Rails anti-CSRF or the same-origin policy. If you have images with sensitive information, then you need an additional system to prevent a third party site from stealing these images.
* If the application has a XSS vulnerability, then CSRF is also defeated.

## Cookies and sessions

* Authentication always triggers a session reset
* data in cookies is untrusted, unless signed
* sessions have a max lifetime
* sessions expire after inactivity

## Assets

* All stylesheets have absolute paths

## HTTP Headers

* Enable secure headers
* Sensitive content is not cached

## Input

* All queries use parameter binding
* User input is not used to build file paths

## Views

* All output is filtered

## Routing and URLs

* There is no sensitive information in any application URLs

## Authorization

* The default is to require authorization
* follows principles of least privilege

## Pipeline

* Dependency checks are run in pipeline
* Static analysis is run in pipeline
