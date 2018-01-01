---
title: Rails 4 Pre-flight Checklist
nav_title: Rails 4
toc: true
---

## Configuration

### The `config.force_ssl` flag is enabled

In `environments/production.rb`:

```ruby
config.force_ssl = true
```

What this does

> This will set a HSTS header in application responses, set the `secure` flag for cookies, and redirect HTTP to HTTPS.

Why this is important

> Even if the web server is configured to require TLS, you probably have a redirect configured from plain HTTP to HTTPS. In these cases, there are many situations where a browser might make a plain HTTP connection attempt, potentionally leaking session information in the clear. By adding an HSTS header and setting the `secure` flag for cookies, you instruct the browser to always require HTTPS.

### Database credentials are stored in the environment

To be written

### Anti-CSRF is enabled

Make sure that the top of `ApplicationController` has `protect_from_forgery`:

```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
```

This is the default when you create a new rails 4 application, but if you upgraded you might not have this.

What this does

> Enabling `protect_from_forgery` will set a value `session[:_csrf_token]` and include `authenticity_token` as a parameter to all your POST requests. If the values don't match, the exception `ActionController::InvalidAuthenticityToken` is raised.

Why this is important

> When a web browser submits a HTTP request, it dutifully includes all matching cookies, *regardless of what web page the request came from*. Without CSRF protection, a nefarious page can get your browser to make requests to a protected site while authenticated as you.

Important details

* Don't disable exceptions: Be very careful if changing `with: :exception`: there are many ways to introduce a vulnerability if you do anything other than throw an exception when the authentity_token does not validate. <https://nvisium.com/blog/2014/09/10/understanding-protectfromforgery/>
* Idempotent HTTP GET: You must remember to make all GET actions idempotent (does not change the data). This is because the Rails anti-CSRF only applies to HTTP POST.
* Images are not protected: Images and other assets are not protected by the Rails anti-CSRF or the same-origin policy. If you have images with sensitive information, then you need an additional system to prevent a third party site from stealing these images.
* If the application has a XSS vulnerability, then CSRF is also defeated.

See also

* <http://guides.rubyonrails.org/v4.2/security.html#csrf-countermeasures>
* <https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF)>

## Cookies and sessions

### Authentication always triggers a session reset

You must always call `reset_session` immediately before setting the user id in the session. For example:

```ruby
class SessionController << ApplicationController
  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      reset_session
      session[:user_id] = user.id
      redirect_to users_path(user)
    else
      ...
    end
  end
end
```

What this does

> By resetting the session before setting critical information in the session, you protect against session fixation attacks.

Why this is important

> There are many ways that an attacker can "pre-seed" a session cookie in the target's browser. Once this is done, browsers follow a simple rule with cookies: if they have a cookie that matches the site, they send the cookie. Because of this, the website has no way to distinguish between legitimate session cookies that are created by the target and nefarious session cookies created by the attacker (and injected into the target's browser).

Important details

* Encrypted and signed session cookies offer no defense against session fixation.
* Even if you are using a third party authentication framework, you may still need to worry about calling `reset_session` yourself. This is true when the framework does not manage the session for you, but just handles the authentication (for example, omniauth).

See also

* <http://guides.rubyonrails.org/v4.2/security.html#session-fixation>

### If used, CookieStore is used carefully

By default, Rails applications will use `ActionDispatch::Session::CookieStore` for sessions. CookieStore is fast, but there are several pitfalls to be aware of when using CookieStore.

Do not store anything in the session...:

* That is large: Cookies have a strict limit of 4k.
* That you don't want the user to see: Cookies are not encrypted, they are merely authenticated with a SHA1 digest.
* That can be replayed: The user can always restore an older version of the cookie, so you can't trust any state information stored in the user's session.

Don't change the default `config/secrets.yml`:

```erb
    production:
      secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
```

This requires a valid session secret be created in the environment. Don't modify this to fall back to a default value if the environment variable is not set.

Because CookieStore is easy to mess up or mis-configure, many people prefer using a traditional database-backed session storage instead.

## Assets

### All stylesheets have absolute paths

All stylesheets have absolute paths (to prevent CSS-injection via "Relative Path Overwrite")

What this does

> To be written

Why this is important

> To be written

## HTTP Headers

### The gem `secureheaders` is enabled

The gem `secureheaders` allows you to conveniently configure many of best practices for HTTP headers and cookie flags.

In the apps `Gemfile`:

```ruby
gem 'secureheaders'
```

In `config/initializers/secure_headers.rb`:

```ruby
SecureHeaders::Configuration.default
```

What this does

> Enabling this gem will give you the following default headers:
> ```
> Content-Security-Policy: default-src 'self' https:; font-src 'self' https: data:; img-src 'self' https: data:; object-src 'none'; script-src https:; style-src 'self' https: 'unsafe-inline'
Strict-Transport-Security: max-age=631138519
> X-Content-Type-Options: nosniff
> X-Download-Options: noopen
> X-Frame-Options: sameorigin
> X-Permitted-Cross-Domain-Policies: none
> X-Xss-Protection: 1; mode=block
> ```
> And cookies:
>
> ```
> Set-Cookie: ....; Secure; HttpOnly; SameSite=Lax
> ```

Why this is important

> By default, web browsers are very lax and forgiving, which is what creates a wide variety of opportunities for attack. The default headers set by `secureheaders` are best practices that instruct the browser to behave more strictly, and to permit many fewer avenues of attack. These options might not work with your application out of the box, but you should modify your application, if possible, to allow your site to work with these headers enabled.

Important details

* `secureheaders` does nothing to prevent sensitive information from being cached by the web browser. For this, you must set `Cache-Control` header to `no-store`. See below.

See also

* For more configuration options, see <https://github.com/twitter/secureheaders/>
* <https://www.owasp.org/index.php/Content_Security_Policy_Cheat_Sheet>

TODO

* Decide on CSP recommendation, given the vulnerabilities in almost all CSPs that don't use a separate domain for assets.
* Explore a more strict recommendation than the `secureheaders` default.

### Sensitive content is not cached

If your application has sensitive content, you should instruct the browser to not cache the pages at all:

```ruby
class ApplicationController < ActionController::Base
  before_filter :no_cache_header
  protected
  def no_cache_header
    response.headers["Cache-Control"] = "max-age=0, private, no-store"
  end
end
```

The important element here is `no-store`. The Rails default of `no-cache` [does not prevent the browser from caching the result](https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/http-caching). It just prevents the browser from using it's cached copy without first requesting the headers to see if the content has changed.

What is the attack here? Without `no-store` set, anyone who walks up to the browser and opens the cache will get the full content of all pages that a user has recently visited. Only the `no-store` option for `Cache-Control` will prevent the page contents from being saved and accessible via the browser's cache.

To view the cache, open these in the browser's location bar:

* Chrome: chrome://cache
* Firefox: about:cache

Also, you should make sure that cookies and localstorage are cleared when the user logs out.

Why this is important

> Web browsers store on disk and in memory a lot of information about your site, information that is potentially very sensitive. If there is a concern that an attacker might gain physical access to a computer, then it is best to make sure your site does not have it's pages and localstorage saved.

## Databases

### All queries use parameter binding

For example, this:

```ruby
User.where(:name => params[:name])
```

But NOT this:

```ruby
User.where("name = '#{params[:name]}'")
```

Some ActiveRecord methods do not use parameter binding, even though it looks like they should. For example, these are vulnerable to SQL injection:

```ruby
User.calculate(:sum, params[:column])
User.exist?(params[:id])
```

The `exist?` method in ActiveRecord only performs sanitization on string arguments. But an attacker can easy craft a request that results in `params[:id]` being an array. For example:

```ruby
User.exist?(["id = 1) AND 0; --"])
```

Will result in the following SQL:

```sql
SELECT 1 AS one FROM "users" WHERE (id = 1) AND 0; --) LIMIT 1
```

Why it is important

> Parameters queries, or stored procedures with binding, are the only way to prevent SQL injection. Please do not attempt to write your own sanitization routines: it is very difficult to account for all the weird ways in which nefarious strings can get passed your filters.

TODO

* There does not appear to be a proper way to do parameter binding when making SQL calls using the database connection object directly (e.g. User.connection.select_values). Recommendation? Use sequel gem?


## Views

### All output is filtered

Remember, all user input should be treated as untrusted and potentially hostile. This is true even if you have attempted to filter this input and only store "safe" values in the database.

By default, Rails will filter all strings that are rendered to the page:

```erb
<%= possibly_user_input %>
```

However, Rails also lets you easily bypass the filtering. All these will create the possibility of a XSS vulnerability:

```erb
<%= raw possibly_user_input %>
<%= possibly_user_input.html_safe %>
<%= content_tag possibly_user_input %>
<%= link_to "Website", possibly_user_input %>
```

The methods `raw` and `html_safe` should used with extreme caution, and only on strings that have no user supplied input.

## Routing and URLs

### There is no sensitive information in any application URLs

For example, the application should never have `?session_id=e1e6a6acadc40d2` in the URL, even for requests which redirect and do not load any page content.

Why this is important

> Browsers send the HTTP referrer to whatever links a user clicks on, potentially leaking the sensitive URL. Even if that is not a possibility, the browser will still send the referrer for other requests triggered by the page, such as images an stylesheets.
>
> There are several attacks that can take advantage of this fact to exfiltrate any sensitive information in the URL. For example, "Relative Path Overwrite".
>
> You can still include sensitive information in the request parameters, but these values must not appear in the URL part of the request.

## Authorization

### The default is to require authorization

There are two approaches to authorization:

1. The good way: require authorization by default, and then explicitly skip it when not needed.
2. The bad way: have no default authorization, and only require it when needed.

The good way:

```ruby
class ApplicationController < ActionController::Base
  before_action :require_authorization

  protected

  def require_authorization
    ...
  end
end

class HomeController < ApplicationController
  skip_before_action :require_authorization, only: :index
  ...
end
```

The bad way:

```ruby
class ApplicationController < ActionController::Base
  protected
  def require_authorization
    ...
  end
end

class InventoryController < ApplicationController
  before_action :require_authorization
  ...
end
```

Why this is important

> For something critical like authorization, you want to practice defensive programming. If there is an error in how authorization is defined for an action, it is much better to fall back to a safe default, or a hard fail, rather than to fall back to a state that leaves your application open to attack.

## Pipeline

See [[ruby-tools]] for running dependency check and static analysis in your CI pipeline.

## Links

* <http://guides.rubyonrails.org/v4.2/security.html>
* <https://www.owasp.org/index.php/Ruby_on_Rails_Cheatsheet>
* <https://thoughtworks.jiveon.com/docs/DOC-43719>
* <https://rorsecurity.info/>
* HTML5 Security Cheatsheet <https://html5sec.org/>
