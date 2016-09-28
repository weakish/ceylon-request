"Root exception."
shared class RequestException(shared String description)
        extends Exception(description) {}

"Network problems such as DNS failure and not connected."
shared class ConnectionError(shared String url, shared String reason)
        extends RequestException("Cannot connect to ``url``: ``reason``") {}

"Thrown if the HTTP request returned an unsuccessful status code.
 Generally 2xx are sucessful, but your application may have a different meaning of 'success'."
shared class HttpError(shared Integer status, shared String url, shared String method = "GET")
        extends RequestException("Got ``status`` when accessing ``url`` with ``method``") {}

"Thrown if a request times out."
shared class TimeoutError(shared String url, shared String method = "GET")
        extends RequestException("``url`` times out.") {}

"Thrown if specified number of maximum redirections exceeded."
shared class TooManyRedirectsError(shared String url, shared String method = "GET")
        extends RequestException("``url`` exceeds specified maximum redirection number") {}
