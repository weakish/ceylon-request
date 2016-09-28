# Compatible with GNU make and BSD make.

build:
	@ant compile

doc:
	@ceylon doc `ceylon version` --resource-folder=resources


run-test:
	@ceylon test `ceylon version`

test: build run-test

fat-jar:
	@ceylon fat-jar `ceylon version`

jar: build fat-jar

js:
	@ceylon compile-js

# No `test-js` since `ceylon.interop.browser` is an untestable dynamic interface
# See [#615] for more information.
# [615]: https://github.com/ceylon/ceylon-sdk/issues/615
