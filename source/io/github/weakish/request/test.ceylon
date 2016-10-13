import ceylon.test {
    beforeTest,
    test,
    assertEquals,
    assertTrue,
    assertThatException
}

"This module is tested against `https://httpbin.org`.
 Customize host via environment variable `HTTPBIN`."
variable String host = "https://httpbin.org";

beforeTest void init() {
    if (exists httpbin = process.environmentVariableValue("HTTPBIN")) {
        host = httpbin;
    }
}

test void successfully_get() {
    assertTrue(get("``host``/user-agent") is String);
}

test void unsuccessfully_get() {
    assertEquals(get("``host``/status/418"), 418);
}

test void unsuccessfully_try_get() {
    assertThatException(() => try_get("``host``/status/418")).hasType(`HttpError`);
}

test void got_404() {
    assertThatException(() => try_get("``host``/status/404")).hasType(`HttpError`);
}

class Customized404Exception(shared String url_string) extends HttpError(404, url_string) {}

Nothing customized_404_handler(String url) {
    throw Customized404Exception(url);
}

test void customize_404_handler() {
    assertThatException(
            () => try_get("``host``/status/404", customized_404_handler)
    ).hasType(`Customized404Exception`);
}