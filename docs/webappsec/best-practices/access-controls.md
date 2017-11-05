## Proper Access Controls
This one is tricky as it is very dependent on the context of your application. Here are some things to consider:

* How do users authenticate? Are you using a [secure library][saml-vuln]?
* Should only privileged users have access to certain resources? Where are these roles stored? Could they be [manipulated by user input][mass-assignment]?
* What systems/services can access your database?

This last point is absolutely critical. App context varies, but **an anonymous user/system/service should never be able to access your database**. Make sure there is a strong authentication model for your database.

More Resources:

* [OWASP Authentication Cheat Sheet](https://www.owasp.org/index.php/Authentication_Cheat_Sheet)
* [MongoDB](https://docs.mongodb.com/manual/security/)
* [AWS Elastic Search](https://aws.amazon.com/blogs/security/how-to-control-access-to-your-amazon-elasticsearch-service-domain/)
* [MySQL](https://dev.mysql.com/doc/refman/5.7/en/privilege-system.html)
* [PostgreSQL](https://www.postgresql.org/docs/9.4/static/auth-methods.html)
* [Microsoft SQL Server](https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql/authentication-in-sql-server)

[saml-vuln]: https://nvd.nist.gov/vuln/detail/CVE-2016-5697
[mass-assignment]: https://www.owasp.org/index.php/Mass_Assignment_Cheat_Sheet

