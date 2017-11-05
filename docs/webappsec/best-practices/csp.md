# Content Security Policy

# Description

Content Security Policy limits the resources that a web browser will
load, making it more difficult for attackers to carry out a
[Cross Site Scripting](https://www.owasp.org/index.php/Cross-site_Scripting_%28XSS%29)
attack.

When enabling CSP, we can define a whitelist of resources that the
browser will load. Any resources (even including inline scripts) that
are not explicitly enabled in the whitelist will be blocked by the browser.

As an [exploit mitigation](https://blogs.technet.microsoft.com/srd/2013/09/27/software-defense-series-exploit-mitigation-and-vulnerability-detection/),
it's important to remember that while CSP makes exploitation more
difficult, it does not prevent the bugs that make an exploit possible
in the first place (lack of appropriate
encoding/sanitization). Therefore, its protection will never be
complete, and people will continue to find bypasses for even the most
rigerous policies. That said, it's an important part of a Defense in
Depth strategy for any web application.

# Acceptance Criteria

* A policy is created that blocks any resources not required by the application
* The policy is enabled via the `Content-Security-Policy` header
* An api or service is created to parse CSP reports
* Reporting is enabled via the `report-uri` directive
* The team understands what limitations CSP adds, and how to check for violations
* The team has a process for updating the policy as requirements change

# Resources

* https://scotthelme.co.uk/content-security-policy-an-introduction/
* https://developers.google.com/web/fundamentals/security/csp/
