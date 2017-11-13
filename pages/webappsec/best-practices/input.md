---
title: Validate User Input
---

https://martinfowler.com/articles/web-security-basics.html

Reject Unexpected Form Input

* White list when you can
* Black list when you can't whitelist
* Keep your contract as restrictive as possible
* Make sure you alert about the possible attack
* Avoid reflecting input back to a user
* Reject the web content before it gets deeper into application logic to minimize ways to mishandle untrusted data or, even better, use your web framework to whitelist input

Encode HTML Output

* Output encode all application data on output with an appropriate codec
* Use your framework's output encoding capability, if available
* Avoid nested rendering contexts as much as possible
* Store your data in raw form and encode at rendering time
* Avoid unsafe framework and JavaScript calls that avoid encoding

Bind Parameters for Database Queries

* Avoid building SQL (or NoSQL equivalent) from user input
* Bind all parameterized data, both queries and stored procedures
* Use the native driver binding function rather than trying to handle the encoding yourself
* Don't think stored procedures or ORM tools will save you. You need to use binding functions for those, too
* NoSQL doesn't make you injection-proof


## Validate User Inputs

If you have fields that accept user input in your application, making it a priority have some validations on this input is imperative to a basic level of security on your application.

An [excellent blog][mfowler-webappsec-input] post by Cade Cairns and Daniel Somerfield outlines some of the dangers of accepting as-is user input, along with some mitigation strategies.

Here are some of the main takeaways:

* Accepting unvalidated input can lead to an attacker taking control of the app itself.
* Setup alerts for potential attacks.
* Whitelist (positive validation) expected inputs **over** blacklisting a set of known unwanted inputs (negative validation). Make your whitelist strict.
* "Resist the temptation to filter out invalid input" aka "sanitization". **Reject invalid input altogether.**

In a similar vein (and in the same blog post), take care to [encode HTML output][mfowler-webappsec-input] as well.

[mfowler-webappsec-input]: https://martinfowler.com/articles/web-security-basics.html#RejectUnexpectedFormInput

[mfowler-webappsec-input]: https://martinfowler.com/articles/web-security-basics.html#EncodeHtmlOutput

