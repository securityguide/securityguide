

https://www.npmjs.com/package/helmet
help secure Express/Connect apps with various HTTP headers

Commercial Tools
https://geekflare.com/nodejs-security-scanner/

OWASP Dependency Check

https://jeremylong.github.io/DependencyCheck/dependency-check-cli/index.html

For javascript, you need `--enableExperimental`

    dependency-check.sh --enableExperimental --project 'xxxx' --scan /path/to/project




expressjs
==============================

http://expressjs.com/en/advanced/best-practice-security.html

secure cookie options
--------------------------------

const express = require('express')
const session = require('express-session')

const app = express()
const hour = 3600000
app.use(session({
  cookie: { secure: true, sameSite: true, maxAge: hour }
}))

secure header options
----------------------------

const express = require('express')
const helmet = require('helmet')

const app = express()
app.use(helmet())

https://github.com/helmetjs/helmet

csrf
------------------

https://www.npmjs.com/package/csurf

