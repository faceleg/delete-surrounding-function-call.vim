# delete-surrounding-function-call.vim

Provides `dsf` mapping that will delete a surrounding function call when invoked.

## Examples

 - `foo(ba|r);` *dsf* results in `ba|r`
 - `Module::Foo.new("b|ar")` *dsf* results in `b|ar`
 - `foo(baz(ba|r));` *dsf* results in `foo(ba|r)`

## Credit

Lovingly copy-pasted from [Andrew Radev's](https://github.com/AndrewRadev) [How I Vim](http://howivim.com/2016/andrew-radev) post.
