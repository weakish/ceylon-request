"""This module provides http client functions on JVM and JS.

   The downsides of `ceylon.net.http.client`:

   - Only supports JVM, no JS support.
   - A bit too verbose for simple usage.

   Currently only support `GET`:

   ```ceylon
   switch (result = get("https://example.com"))
   case (is String) {
       print("response: status 200, body: ``result``");
   }
   case (is Integer) {
       print("response: status ``result``");
   }

   It also provides common request exceptions.
   ```"""
license("0BSD")
module io.github.weakish.request "0.0.2016" {
    native("jvm") import ceylon.uri "1.3.0";
    native("jvm") import ceylon.http.client "1.3.0";
    native("js") import ceylon.interop.browser "1.3.0";
    import ceylon.test "1.3.0";
}
