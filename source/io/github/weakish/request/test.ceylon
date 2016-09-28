import ceylon.test {
    beforeTest,
    test,
    assertEquals,
    assertTrue
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

test void got_404() {
    assertEquals(get("``host``/status/418"), 418);
}