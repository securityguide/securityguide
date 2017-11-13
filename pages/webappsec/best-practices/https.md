---
title: Enforce HTTPS
toc: true
---

Protect Data in Transit

* Use HTTPS for everything!
* Use HSTS to enforce it
* You will need a certificate from a trusted certificate authority if you plan to trust normal web browsers
* Protect your private key
* Use a configuration tool to help adopt a secure HTTPS configuration
* Set the "secure" flag in cookies
* Be mindful not to leak sensitive data in URLs
* Verify your server configuration after enabling HTTPS and every few months thereafter

## Enforce HTTPS

Please just do it. Enforcing HTTPS is the best policy, for many many reasons.

Unfortunately, enforcing HTTPS on the server does not not necessarily mean that the browser will not attempt plaintext HTTP connections. If the browser has a session cookie, then these plaintext connection attempts will leak the session to any network observer.

To prevent session hijacking and SSL striping attacks, you need to additional enable the following:

* Ensure that the [[Secure cookie flag is set => abusing-cookies]].
* Ensure that HTTP Strict Transport Security ([HSTS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security)) is set.

## Understanding X.509

To be written

## Recommended configuration

Web server configurations that enforce HTTPS and also use a good cipher list.

### Apache

```
<VirtualHost *:80>
  ServerName DOMAIN
  ServerAlias WWW_DOMAIN
  RewriteEngine On
  RewriteRule ^.*$ https://DOMAIN%{REQUEST_URI} [R=permanent,L]
</VirtualHost>

<VirtualHost *:443>
  ServerName DOMAIN
  ServerAlias WWW_DOMAIN

  SSLEngine on
  SSLProtocol all -SSLv2 -SSLv3
  SSLHonorCipherOrder on
  SSLCompression off
  SSLCipherSuite "ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!3DES:!RC4:!MD5:!PSK!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA"

  RequestHeader set X_FORWARDED_PROTO 'https'

  SSLCACertificatePath /etc/ssl/certs
  SSLCertificateKeyFile /path/to/private.key
  SSLCertificateFile /path/to/cert.crt

  <IfModule mod_headers.c>
    Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
    Header always unset X-Powered-By
    Header always unset X-Runtime
  </IfModule>
</VirtualHost>
```

### Nginx

To be written

## Client certification authentication

To be written
