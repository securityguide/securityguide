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

