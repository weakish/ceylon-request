import ceylon.uri {
    Uri,
    parse
}
import ceylon.http.client {
    Response,
    get_uri = get
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
    Response response = get_uri(uri).execute();
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

"Default 404 handler."
Nothing throw_404(String url) {
    throw HttpError(404, url);
}

"Like [[get]], but throws customizable exception on 404, and HttpError for others."
throws(`class HttpError`, "non sucesseful requests")
suppressWarnings("expressionTypeNothing")
shared String try_get(String url, Nothing(String) handle_404 = throw_404) {
    switch (result = get(url))
    case (is String) {
        return result;
    }
    case (is Integer) {
        switch (status = result)
        case (404) {
            return handle_404(url);
        }
        else {
            throw HttpError(status, url);
        }
    }
}
