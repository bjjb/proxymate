Proxymate
=========

Proxymate is a simple little NodeJS proxy server.  It lets you configure
endpoints which can be adjusted on the fly (with settings stored in Redis),
allowing you to do things like embed credentials or CORS - making it a handy
endpoint for static web apps.

Installation
------------

    npm install -g proxymate

Usage
-----

To, for example, run proxymate on TCP port 6379, using a remote Redis backend
to store the configuration:

    PORT=8080 REDIS_URL=redis://redis.host:6379/proxymate proxymate

There are some more options which are configurable via the environment; see
the [source][] for details.

Contributing
------------

If you have bug fixes or improvements, feel free to contribute!

Take (or create) an issue on GitHub, fork the project, write your changes, and
submit a pull request. PRs will be accepted if they make sense, adhere to the
same coding style, and all tests pass. The project is [semantically
versioned][semver], so don't forget to update the appropriate version number
(and the documentation).

The source is in coffee-script, because that's still nicer to work as of this
writing, but I'm open to moving to ES2017 if the need arises.

[source]: https://github.com/bjjb/proxymate/blob/master/proxymate.coffee
[semver]: https://semver.org
