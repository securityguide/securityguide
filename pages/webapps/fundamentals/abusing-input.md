---
title: Abusing Input
description: Don't. Trust. The. User. Ever. That is pretty much it.
toc: true
---

## SQL Injection

"SQL Injection" is a security vulnerability with a very simple cause: it occurs whenever user input is not properly filtered when SQL queries are built.

It is one of the most common vulnerabilities, can lead to total compromise of the database, and is also easy to prevent.

To prevent SQL Injection:

* Always use parameter binding. Almost all libraries for accessing a database include some API for "parameter binding". You should always use these built-in methods.
* Avoid every trying to filter input yourself. Use the parameter binding feature that is already built into the database library you are using.
* If you are creating a custom query that must bypass parameter binding, try to exercise extreme caution. For example, only allow a very limited set of characters in the user input.

### Examples

A vulnerable query (java):

```java
String query = "SELECT account_balance FROM user_data WHERE user_name = " + request.getParameter("customerName");
Statement statement = connection.createStatement(...);
ResultSet results = statement.executeQuery(query);
```

In this vulnerable query, if the parameter `customerName` contained `''; DROP TABLE user_data;` then an attacker could destroy the database (there are other techniques that can be used to exfiltrate data as well).

A safe query using parameter binding (java):

```java
String custname = request.getParameter("customerName");
String query = "SELECT account_balance FROM user_data WHERE user_name = ? ";
PreparedStatement pstmt = connection.prepareStatement(query);
pstmt.setString(1, custname);
ResultSet results = pstmt.executeQuery();
```

### Where it gets tricky

Many database APIs will not use parameter binding for all calls, even when it looks like they do. For example, in Ruby using ActiveRecord, this call is unsafe:

```ruby
User.exist?(params[:id])
```

If `params[:id]` is encoded as an array by the attacker, then it will allow an attacker to bypass any input filtering.

A static analysis tool in your test pipeline should help detect these sort of non-obvious errors for you.

### Further reading

* [netspi SQL wiki](https://sqlwiki.netspi.com/), An excellent in-depth look at SQL injection.
* [OWASP page on SQL injection](https://www.owasp.org/index.php/SQL_Injection)
* [OWASP SQL Injection Prevention Cheat Sheet](https://www.owasp.org/index.php/SQL_Injection_Prevention_Cheat_Sheet)
