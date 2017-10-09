Proxymate
=========

Proxymate is a simple managed proxy server. It consists of a Go service which
listens for requests containing a specific set of headers, and uses those
headers to proxy the request to an upstream server.

Usage
-----

To, for example, run proxymate on TCP port 6379, using a local Redis backend
to store the configuration:

    PORT=8899 REDIS_URL=redis://localhost:6379/proxymate proxymate

There are some more options which are configurable via the environment; see
the [source][] for details.

Proxy Control
-------------

The proxy is controlled by the following headers:

| Header                     | Description                                   |
| -------------------------- | ----------------------------------------------|
| [X-Proxymate-Host][1]      | The hostname to proxy the request to          |
| [X-Proxymate-Include][2]   | Include extra headers in the upstream request |
| [X-Proxymate-Exclude][2]   | Exclude headers from the upstream request     |
| [X-Proxymate-Transform][3] | Convert between encodings                     |
| [X-Proxymate-Key][4]       | Required to modify proxy settings             |

When proxymate receives a request which includes the `X-Proxymate-Host`
header, it will duplicate the request, then add additional headers for every
`X-Proxymate-Include` header, then remove any headers specified by a
`X-Proxymate-Exclude` header. You may use multiple instances of these headers,
or use comma-separated values (as in RFC2616). 

Proxymate will add `Access-Control-Allow-Origin: *` and
`Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept`
to its responses, so you can use it as a simple workaround for
[non-CORS][nocors] services.

Additionally, Proxymate takes care of caching responses according to RFC7234
(if it is hooked up to a Redis). This is useful when developing a web-app,
since you can use your own Proxymate to avoid hitting a remote service over
and over again with the same request. *Explain how!*

Another benefit is that you can use Proxymate to convert (naïvely) between,
say, XML and JSON in a response body, to simplify the usage of XML APIs, or to
facilitate the submission of an `x-www-urlformencoded` body to an upstream
using JSON.

Finally, each host's proxied behaviour can be tweaked using the in-built
[API][api].

If you **don't** include the `X-Proxymate-Host` header, Proxymate works as a
simple file server, serving the current directory. It ships with a little
web-app API client, which you can use to control the settings.

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
[nocors]: https://enable-cors.org/
