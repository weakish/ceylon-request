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

