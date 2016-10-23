This module provides http client functions on JVM and JS.

Currently only support `GET`.

Doc
---

This module provides http client functions on JVM and JS.

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
```

It also provides common request exceptions.

For more information, see source code.

Install
-------

Download the car file at [Releases] and put it in ceylon module repository.

[Releases]: https://github.com/weakish/ceylon-request/releases

Contribute
----------

Send pull requests at <https://github.com/weakish/ceylon-request>

License
-------

0BSD
