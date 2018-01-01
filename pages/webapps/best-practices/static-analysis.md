---
title: Static analysis
---

### What is it?

A static analysis tool, referred to as a Static Application Security Tool (SAST) in the context of security, identifies potential security flaws in source code, byte code, and binaries. SAST tools provide a powerful way to identify potential defects by analyzing applications from the "inside out". This provides much greater sight into possible flaws than a scanner that only interacts with a application as a user would.

### Why is it needed?

* Sometimes the easiest or most obvious way to do something is also not secure.
  These tools provide fast feedback if a mistake is made.
* Continuous, fast feedback about potential vulnerabilities saves teams time and
  stress.

### When should I use this?

* In your CI pipeline. Automatically run the scanner periodically, possibly
  alongside other automated tests following a checkin if it can complete quickly
  enough.
* During manual testing. More in-depth scans can be run and verified along with
  the other necessary manual tests. Testers can also start to do some
  exploratory security testing after familiarizing themselves with typical
  weaknesses.

### Tools

* [[agnostic-static-analysis]]
* [[java-static-analysis]]
* [[javascript-static-analysis]]
* [[python-static-analysis]]
* [[ruby-static-analysis]]

### Further reading

* [Wikipedia page on static program analysis](https://en.wikipedia.org/wiki/Static_program_analysis)
* [Wikipedia list of static program analyzers](https://en.wikipedia.org/wiki/List_of_tools_for_static_code_analysis)
* [OWASP wiki page on static program analysis](https://www.owasp.org/index.php/Static_Code_Analysis)
* [NIST list of security-focused static program analyzers](https://samate.nist.gov/index.php/Source_Code_Security_Analyzers.html)

