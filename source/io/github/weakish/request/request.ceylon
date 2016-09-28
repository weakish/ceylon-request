import ceylon.net.uri {
    Uri,
    parse
}
import ceylon.net.http.client {
    Response
}
import ceylon.interop.browser {
    XMLHttpRequest,
    newXMLHttpRequest
}


"Given a Url String, returns GET Response content when success (200),
 otherwise returns status code."
native shared String|Integer get(String url);

native("jvm") shared String|Integer get(String url) {
    Uri uri = parse(url);
    Response response = uri.get().execute();
    switch (status = response.status)
    case (200) { // OK
        return response.contents;
    }
    else {
        return status;
    }
}

native("js") shared String|Integer get(String url) {
    XMLHttpRequest xMLHttpRequest = newXMLHttpRequest();
    xMLHttpRequest.open("GET", url);
    switch (status = xMLHttpRequest.status)
    case (200) { // OK
        return xMLHttpRequest.responseText;
    }
    else {
        return status;
    }
}

"Root exception."
shared class RequestException(shared String description)
        extends Exception(description) {}

"Network problems such as DNS failure and not connected."
shared class ConnectionError(shared String url, shared String reason)
        extends RequestException("Cannot connect to ``url``: ``reason``") {}

"Thrown if the HTTP request returned an unsuccessful status code.
 Generally 2xx are sucessful, but your application may have a different meaning of 'success'."
shared class HTTPError(shared Integer status, shared String url, shared String method = "GET")
        extends RequestException("Got ``status`` when accessing ``url`` with ``method``") {}

"Thrown if a request times out."
shared class TimeoutError(shared String url, shared String method = "GET")
        extends RequestException("``url`` times out.") {}

"Thrown if specified number of maximum redirections exceeded."
shared class TooManyRedirectsError(shared String url, shared String method = "GET")
        extends RequestException("``url`` exceeds specified maximum redirection number") {}