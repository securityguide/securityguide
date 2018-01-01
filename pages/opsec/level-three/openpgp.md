---
title: OpenPGP
toc: true
---

# About OpenPGP

This is a highly technical and labor-intensive initiative to undertake, but is probably the most complete way to minimize any inadvertent disclosure of data through email. Email encryption hides all email content from any servers or network providers that pass your mail along. It will likely require inconvenience for your team and significant changes to staff practices, but it provides strong protection of sensitive information emailed within your organization (and, if it is relevant to you, far greater compliance with standards such as HIPAA). There are various ways to implement email encryption, but only some are truly "end to end," meaning that you don't have to trust any parties in the middle, and encryption and decryption only happens on the devices communicating with each other.

The most common type of end-to-end encryption for email is called Pretty Good Privacy (PGP) and has been around for a long time. The open standard is called "OpenPGP" (not PGP).

# Terminology

* Private Key: The private key is used to decrypt messages. This is the key that you must keep secret. This private key allows you to read incoming messages that people send you and to sign outgoing messages to attest that they really come from you.
* Public Key: The public key is used to encrypt messages. This is the key that you hand out publicly to everyone. This key allows anyone to create a message that only the holder of the private key can read.
* Fingerprint: In terms of message security, a fingerprint is an unique identifier for a particular public key.
* Signature: Signatures are made by private keys to ensure **authenticity** of a message by allowing the recipient to verify the signature and gain confidence that the message really came from the private key they have associated with a particular person.
* Encryption: Encryption is a method of ensuring **confidentiality** by hiding the contents of a message. Encrypting a message transforms the message so that it appears to be meaningless, but can still be restored to its original form by a person or device that possesses the right secret key. This limits who can access the information because without the right secret key, it should be impossible to reverse the encryption and recover the original information.

# Tools

* Thunderbird: One common tool for for using OpenPGP encryption with email is the [Mozilla Thunderbird email client](https://www.mozilla.org/en-US/thunderbird/) (https://www.mozilla.org/en-US/thunderbird/) and the associated [Enigmail plugin](https://www.enigmail.net/home/index.php) (https://www.enigmail.net/home/index.php), which works on Windows (with the addition of [GPG4Win](https://gpg4win.org/) (https://gpg4win.org/), Mac, and Linux). You can find a guide for the Windows setup at [https://securityinabox.org/en/guide/thunderbird/windows](https://securityinabox.org/en/guide/thunderbird/windows).
* macOS Mail: the macOS built-in Mail program and the open-source add on [GPGTools](https://gpgtools.org) (https://gpgtools.org) is also a workable toolset for using OpenPGP email on Macs.
* Outlook: Microsoft Outlook works best with a commercial add-on called [gpg4o](https://www.giepa.de/products/gpg4o/?lang=en) (https://www.giepa.de/products/gpg4o/?lang=en) to use OpenPGP encryption with Microsoft Exchange.
* [Mailvelope](https://www.mailvelope.com) https://www.mailvelope.com) is a powerful and well-audited OpenPGP add-on for web browsers that allows you to use OpenPGP encryption with almost any webmail service, including Gmail. Because of its position inside a web browser, its security is generally less assured than the other OpenPGP options above, but is adequate for many organizations, especially when coupled with strong web browser profile controls and careful use of browser extensions as well as other safe browsing practices.

# Alternatives

For organizations with more resources, S/MIME is an alternate encryption scheme that works well with a Microsoft Exchange/Outlook environment or with Gmail by installing the [Penango plug-in](https://www.penango.com) (https://www.penango.com) or using [Google's native offering](https://support.google.com/a/answer/6374496) (https://support.google.com/a/answer/6374496), which requires use of the G Suite Enterprise paid services.

As alternatives, several third-party-managed encryption tools for email exist. One popular such service is [Virtru](https://virtru.com) (https://virtru.com); it is available for Gmail and works best if used only with Gmail users. If you are able to transition your email entirely to their platform, [ProtonMail](https://protonmail.com/) (https://protonmail.com/) is an open source end-to-end encrypted email provider that has implemented common PGP encryption in a package that is easier to use than the toolsets named above and solves a lot of key management problems to make secure email more seamless for users.

Google's S/MIME option, ProtonMail and Virtru are end-to-end encryption offerings that function with a strong trust dependency on the vendor to produce, manage, and swap encryption keys for seamless emailing. If you are interested in these solutions, be aware that you are entering into a high-trust relationship with the vendor. If wanting to implement any encryption scheme mentioned here for your email, you will need to talk to your technical support provider and be prepared to invest time and resources into planning, implementation, and training.

# See also

* [Security Self-defense / An Introduction to Public Key Cryptography and PGP](https://ssd.eff.org/en/module/introduction-public-key-cryptography-and-pgp)
* [Security Self-defense / How to: Use PGP for Linux](https://ssd.eff.org/en/module/how-use-pgp-linux)
* [Security Self-defense / How to: Use PGP for macOS](https://ssd.eff.org/en/module/how-use-pgp-mac-os-x)
* [Security Self-defense / How to: Use PGP for Windows](https://ssd.eff.org/en/module/how-use-pgp-windows)

