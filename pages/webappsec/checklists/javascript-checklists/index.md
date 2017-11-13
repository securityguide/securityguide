---
title: Javascript Checklists
nav_title: Javascript
---

## Platforms

* [[expressjs]]
* [[nodejs]]

## Secure Coding Practices

### Avoid stringify()

The command `JSON.stringify()` is not safe and can lead to XSS attacks.

Instead, use `serialize-javascript`:

    $npm install --save-dev serialize-javascript

* [View on GitHub](https://github.com/yahoo/serialize-javascript)
* [Security risk details](https://medium.com/node-security/the-most-common-xss-vulnerability-in-react-js-applications-2bdffbcc1fa0)

## Resources & Advisories

<https://medium.com/node-security>