---
title: Better Browsing
toc: true
description: Adjust your web browser for greater security.
---

# Keep your browser up to date

All four major web browsers, Firefox, Chrome, Microsoft Edge, and Safari, have experienced severe security flaws in the recent past, so you should make sure you are using the most up-to-date version, whichever one you choose.

If you have install the web browser through the offical application store for your operating system, then the store should take care of updates.

Otherwise, the browser will alert you when a new version of the application is available. Do not ignore these alerts! Yes, new applications are not always better or more fun to use, but when it comes to web browers it is vitally important to be running the latest release.

# Adjust your settings

## Disable third-party cookies

Third-party cookies are tracking identifiers used by advertising networks to track your behavior as you browse from website to website. They are an abomination and serve no legitimate purpose.

* Firefox: Preferences > Privacy > Accept third-party cookies > Never.
* Chrome: Settings > Show advanced settings... > Content settings > Block third-party cookies and site data.

## Clear cookies on exit

Most browsers keep cookies around much longer than necessary. It is best to configure your browser to delete cookies when you quit the browser.

* Firefox: Preferences > Privacy > Keep until > I close Firefox.
* Chrome: Settings > Show advanced settings... > Content settings > Keep local data only until you quit your browser.

## Disable Flash

Flash is a plug-in from Adobe that has been the cause an endless stream of security problems. We highly recommend that you remove or disable Flash.

* Firefox: Add-ons > Plugins > Flash > Never Activate.
* Chrome: Settings > Show advanced settings... > Content settings > Do not run plugins by default.

## Disable Java

Java also has many security problems and you probably have never used it. Remove or disable it with haste.

* Firefox: Add-ons > Plugins > Java > Never Activate.
* Chrome: Settings > Show advanced settings... > Content settings > Do not run plugins by default.

## Change default search engine

While you are adjusting your setting, take the opportunity to change your default search engine to [[duckduckgo.com => https://duckduckgo.com]]. Unlike Google and Bing, DuckDuckGo does not track your searches in order to sell your behavior to advertisers. The best way to avoid leaking your data to an attacker is to ensure that the data is never stored in the first place. See instructions for [[desktop browsers => https://duck.co/help/desktop/adding-duckduckgo-to-your-browser]] or [[mobile browsers => https://duck.co/help/mobile]].

# Browser extensions

The extensions in this list work for both Firefox and Chrome, unless otherwise noted.

## Essential extensions

These are absolutely essential browser extensions that everyone should be using all the time. They are stable, open source, and rarely cause websites to break.

[[uBlock Origin -> https://github.com/gorhill/uBlock]]
: uBlock prevents most advertisements and tracking networks. It is similar to Adblock Plus or Disconnect but works better and is much faster. Install for [[Chrome => https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm]], [[Firefox => https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/]].

[[HTTPS Everywhere => https://www.eff.org/https-everywhere]]
: HTTPS Everywhere will automatically switch to secure TLS connections whenever the website supports it. This helps to protect against surveillance of the content of your web browsing, although it does not hide which websites you are visiting (unless you also run [[Tor]] or a [[VPN]]).

[[Privacy Badger => https://www.eff.org/privacybadger]]
: Privacy Badger dynamically detects attempts to track your browsing behavior and blocks content from these trackers. Privacy Badger is not designed to stop ads, so it is not a replacement for uBlock, but it includes some security features that uBlock (in default mode) does not have.

Usage notes:

* Leaking IP addresses: All browsers will leak your real IP address when using audio or video conferencing. If you use a VPN or Tor with audio or video chat, then you should open the uBlock settings and enable the option that prevents WebRTC from leaking your real IP address.
* uBlock advanced mode: If you run uBlock in [[advanced mode => https://github.com/gorhill/uBlock/wiki/Advanced-user-features]], you should not also run Privacy Badger.

## Advanced extensions

These extensions are for advanced users because they are complicated to use or cause many websites to malfunction.

These extensions attempt to overcome basic privacy flaws in how web browsers work. However, many websites rely on these privacy flaws for basic functionality, so attempts to fix these problems can often make a website stop working.

Some of these privacy flaws include:

* **HTTP Referrer:** When you click a link, your browser sends to the new website the location of the old website. Because sensitive or personally identifying information might be included in the URL of a particular page, the HTTP Referrer should be disabled. You can only do this with an extension.
* **HTTP User-Agent:** Your web browser sends a special "User-Agent" string to every website that it visits. This string contains a lot of uncommon information that can be used, in combination with other data, to uniquely identify your traffic. There is little point in this browser fingerprint these days, and it is better to use a generic value, such as the one used by the Tor Browser.
* **HTML5 Canvas:** Many websites have started to use the HTML5 Canvas to uniquely fingerprint your browser and track your behavior. There is currently no way to disable this, although some new extensions make a crude attempt.
* **JavaScript:** JavaScript is essential for most websites these days, but there are times when you may wish to disable it. When JavaScript is enabled, it is much easier for a website to fingerprint your browser and track your behavior. Also, most browser security vulnerabilities are caused by JavaScript.

For Firefox:

* [[Self Destructing Cookies (Firefox) => https://addons.mozilla.org/en-US/firefox/addon/self-destructing-cookies/]] will clean out the cookies for a website when all the tabs for that site have been closed (rather than requiring that you restart the browser).
* [[µMatrix => https://addons.mozilla.org/en-US/firefox/addon/umatrix/]] allows you to selectively block Javascript, plugins or other resources and control third-party resources. It also features extensive privacy features like user-agent masquerading, referering blocking and so on. It effectively replaces NoScript and RequestPolicy.
* [[User-Agent Switcher => https://addons.mozilla.org/en-US/firefox/addon/user-agent-switcher/]] will allow you to modify the HTTP User-Agent.
* [[Canvas Fingerprint Blocker => https://addons.mozilla.org/en-US/firefox/addon/canvasblocker/]] will allow you to disable HTML5 canvas support for particular websites.

For Chrome:

* [[µMatrix => https://chrome.google.com/webstore/detail/%C2%B5matrix/ogfcmafjalglgifnmanfmnieipoejdcf]] allows you to selectively block Javascript, plugins or other resources and control third-party resources. It also features extensive privacy features like user-agent masquerading, referering blocking and so on. It effectively replaces NoScript and RequestPolicy.
* [[User-Agent Switcher => https://chrome.google.com/webstore/detail/user-agent-switcher/ffhkkpnppgnfaobgihpdblnhmmbodake]] will allow you to modify the HTTP User-Agent.
* [[CanvasFingerPrintBlock => https://chrome.google.com/webstore/detail/canvasfingerprintblock/ipmjngkmngdcdpmgmiebdmfbkcecdndc]] will block most HTML5 Canvas fingerprinting (not open source).

# See also

* [Security Education Companion / HTTPS Everywhere and Privacy Badger](https://sec.eff.org/topics/https-everywhere-and-privacy-badger)
* [Security Planner / HTTPS Everywhere](https://securityplanner.org/#/tool/https-everywhere)
* [Security Planner / Check Website Names](https://securityplanner.org/#/tool/check-website-names)
* [Security Planner / Privacy Badger](https://securityplanner.org/#/tool/privacy-badger)