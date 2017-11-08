---
title: Abusing Cookies
toc: true
---

# How cookies work

If you have ever done any web programming, you are familiar with cookies. However, you might not be familiar with some of the unexpected ways in which cookies can create security vulnerabilities.

## A look at cookies

Let us start at the beginning: what is a cookie? The HTTP cookie allows a server to store a bit of arbitrary data on the client's device. A cookie is just a KEY=VALUE pair, with some associated attributes the direct the browser when the cookie should be used.

Cookies are just headers set by the server in the HTTP response or by the client in the HTTP request. For example:

### 1. client -> server request

    curl --head -v https://en.wikipedia.org/wiki/Main_Page 2>&1 | grep '^>'

      SIDE NOTE: the `grep '^>'` command will show us just the client's request headers

    > HEAD /wiki/Main_Page HTTP/1.1
    > Host: en.wikipedia.org
    > User-Agent: curl/7.47.0
    > Accept: */*

### 2. client <- server response

    curl --head -v --cookie-jar /tmp/cookie https://en.wikipedia.org/wiki/Main_Page 2>&1 | grep '^<'

      SIDE NOTE:
        * the `--cookie-jar` argument will save the cookies to the file specified
        * the `grep '^<'` command will show us just the server's response headers

    Server responds with two Set-Cookie headers:

    < Set-Cookie: WMF-Last-Access=04-Nov-2016;Path=/;HttpOnly;secure;Expires=Tue, 06 Dec 2016 12:00:00 GMT
    < Set-Cookie: GeoIP=US:::37.75:-97.82:v4; Path=/; secure; Domain=.wikipedia.org

### 3. client -> server request

    curl --head -v --cookie /tmp/cookie https://en.wikipedia.org/wiki/Main_Page 2>&1 | grep '^>'

    When the client next mades a request, it will send these cookies in the request header:

    > HEAD /wiki/Main_Page HTTP/1.1
    > Host: en.wikipedia.org
    > User-Agent: curl/7.47.0
    > Accept: */*
    > Cookie: WMF-Last-Access=31-Oct-2016; GeoIP=US:::37.75:-97.82:v4

## Domains and Paths

* If the domain is not explicitly set by the server, the browser will assign the domain based on the origin of the cookie.

* Sub-domains can set cookies for the parent domain: A page can set a cookie for its own domain or any parent domain, as long as the parent domain is not a public suffix. In other words, sub.domain.org can set a cookie for domain.org, which will also be used for sub2.domain.org. Firefox and Chrome use the Public Suffix List to determine if a domain is a public suffix.

* A cookie for a parent domain is always sent to the sub-domain: a cookie with domain=domain.org or domain=.domain.org will be sent to sub.domain.org. Because of this, a compromise on domain.org can result in session fixation vulnerability for all the subdomains.

* Cookie scheme for determining origin is very different than the same-origin policy. The short hand version: cookie domain is a loose match, same-origin is a very strict match, including protocol and port.

## Cookie Flags

A cookie flag is a suggestion to the client regarding when a cookie should be used.

Example:

    Set-Cookie: KEY=VALUE; Secure; HttpOnly; SameSite=Strict

`Secure`

The secure flag suggests to the client that they cookie should only be used for requests over https.

Why this is highly recommended:

* Suppose your browser has an active session to https://securebank.int, then you type in 'securebank.int' in another tab. Without the `Secure` flag, your browser has just leaked your session id in the clear over the network! This is true even if you don't serve any content on plaintext http and always redirect to https.

`HttpOnly`

This flags prevents javascript from reading the value of the cookie.

Why this is highly recommended:

* This flag makes it harder for XSS attacks to hijack your session by reading the cookie and exfiltrating the session id to the attacker's domain.

`SameSite=Strict`

This flag prevents the cookie from being used by other web pages when they submit forms or get resources from the cookie's domain.

Why this is highly recommended:

* SameSite restrictions are a good way to mitigate CSRF attacks.

## Cookie facts

* Cookie size: Cookies can hold no more than 4096 bytes.
* Duplicate Cookies: It is possible to have multiple cookies with the same name for the same domain. The server must not rely on any particular order of the cookies.


# Abusing Cookies

## Session fixation

By resetting the session before setting critical information in the session, you protect against session fixation attacks.

Why this is important: There are many ways that an attacker can "pre-seed" a session cookie in the target's browser. Once this is done, browsers follow a simple rule with cookies: if they have a cookie that matches the site, they send the cookie. Because of this, the website has no way to distinguish between legitimate session cookies that are created by the target and nefarious session cookies created by the attacker (and injected into the target's browser).

Remember:

* Encrypted and signed session cookies offer no defense against session fixation.
* If you are using a third party authentication framework, you most likely still need to worry about resetting the session yourself. This includes SAML authentication libraries.

## Session hijacking

To be written.

There are various ways that a session ID can leak. Then an attacker can assume your session.

## Cross site request forgery

To be written.

Browsers are stupid: they always send the cookie, regardless of where the POST came from.

## Parsing cookies

To be written.

Cookies are untrusted input. If there is a bug in the parsing code, such as a JSON or XML library, then an attacker can exploit it via cookies
