Abusing cookies
  how cookies work
    set cookie header
    domain and paths
    cookie flags
    duplicate cookies
  how it falls down
    csrf
    session fixation
    session hijacking
    parsing cookies
  best practices
    secure cookie
    new session id
    more specific cookie paths


If you have ever done any web programming, you are familiar with cookies. However, you might not be familiar with some of the unexpected ways in which cookies can create security vulnerabilities.

Let us start at the beginning: what is a cookie? The HTTP cookie allows a server to store a bit of arbitrary data on the client's device. A cookie is just a KEY=VALUE pair, with some associated attributes the direct the browser when the cookie should be used.

How cookies work

1. client -> server request

    curl --head -v https://en.wikipedia.org/wiki/Main_Page 2>&1 | grep '^>'

      SIDE NOTE: the `grep '^>'` command will show us just the client's request headers

    > HEAD /wiki/Main_Page HTTP/1.1
    > Host: en.wikipedia.org
    > User-Agent: curl/7.47.0
    > Accept: */*

2. client <- server response

    curl --head -v --cookie-jar /tmp/cookie https://en.wikipedia.org/wiki/Main_Page 2>&1 | grep '^<'

      SIDE NOTE:
        * the `--cookie-jar` argument will save the cookies to the file specified
        * the `grep '^<'` command will show us just the server's response headers

    Server responds with two Set-Cookie headers:

    < Set-Cookie: WMF-Last-Access=04-Nov-2016;Path=/;HttpOnly;secure;Expires=Tue, 06 Dec 2016 12:00:00 GMT
    < Set-Cookie: GeoIP=US:::37.75:-97.82:v4; Path=/; secure; Domain=.wikipedia.org

3. client -> server request

    curl --head -v --cookie /tmp/cookie https://en.wikipedia.org/wiki/Main_Page 2>&1 | grep '^>'

    When the client next mades a request, it will send these cookies in the request header:

    > HEAD /wiki/Main_Page HTTP/1.1
    > Host: en.wikipedia.org
    > User-Agent: curl/7.47.0
    > Accept: */*
    > Cookie: WMF-Last-Access=31-Oct-2016; GeoIP=US:::37.75:-97.82:v4

    Cookie: xxx=xxx

Domains and Paths

* If the domain is not explicitly set by the server, the browser will assign the domain based on the origin of the cookie.

* Sub-domains can set cookies for the parent domain: A page can set a cookie for its own domain or any parent domain, as long as the parent domain is not a public suffix. In other words, sub.domain.org can set a cookie for domain.org, which will also be used for sub2.domain.org. Firefox and Chrome use the Public Suffix List to determine if a domain is a public suffix.

* A cookie for a parent domain is always sent to the sub-domain: a cookie with domain=domain.org or domain=.domain.org will be sent to sub.domain.org. Because of this, a compromise on domain.org can result in session fixation vulnerability for all the subdomains.

* Cookie scheme for determining origin is very different than the same-origin policy. The short hand version: cookie domain is a loose match, same-origin is a very strict match, including protocol and port.


Flags

  A cookie flag is a suggestion to the client regarding when a cookie should be used.

  Example:

    Set-Cookie: KEY=VALUE; Secure; HttpOnly; SameSite=Strict

  Secure

    The secure flag suggests to the client that they cookie should only be used for requests over https.

    Why this highly recommended:

    * suppose you have an active session to https://securebank.int, then you type in 'securebank.int' in another tab. with the secure flag, your browser has just leaked your session id in the clear over the network.

  HttpOnly

    This flags prevents javascript from reading the value of the cookie.

    Why this is recommended:

    * makes it harder for XSS attacks to hijack your session by reading the cookie and exfiltrating the session id to the attacker's domain.

  SameSite=Strict

    This flag prevents the cookie from being used by other web pages when they submit forms or get resources from the cookie's domain.

    Why this is highly recommended:

    * This is a good and easy method to protect against CSRF attacks.

Duplicate Cookies

It is possible to have multiple cookies with the same name for the same domain. The server must not rely on any particular order of the cookies.



* Cookies can hold no more than 4096 bytes




ruby -r webrick/httpproxy -e 's = WEBrick::HTTPProxyServer.new(Port:8888, RequestCallback: ->(req,res){puts req.header}); trap("INT"){s.shutdown}; s.start'
ruby -r webrick/httpproxy -e 's = WEBrick::HTTPProxyServer.new(Port:8888, RequestCallback: ->(req,res){puts req.header}); trap("INT"){s.shutdown}; s.start'

NOTE:

