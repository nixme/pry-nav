### Using MRI 1.9.2+? Switch to [**pry-debugger**][pry-debugger].
### Using MRI 2+? Switch to [**pry-byebug**][pry-byebug].

Same features as **pry-nav** but with faster tracing, breakpoints, and more.

* * *

pry-nav [![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/nixme/pry-nav/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
=======

_Simple execution control in Pry_

Teaches [Pry][pry] about **step**, **next**, and **continue** to create a simple
debugger.

To use, invoke pry normally:

```ruby
def some_method
  binding.pry          # Execution will stop here.
  puts 'Hello World'   # Run 'step' or 'next' in the console to move here.
end
```

**pry-nav** is not yet thread-safe, so only use in single-threaded environments.

Rudimentary support for [pry-remote][pry-remote] (>= 0.1.1) is also included.
Ensure pry-remote is loaded or required before pry-nav. For example, in a
Gemfile:

```ruby
gem 'pry'
gem 'pry-remote'
gem 'pry-nav'
```

Stepping through code often? Add the following shortcuts to `~/.pryrc`:

```ruby
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
```

Debugging functionality is implemented through
[`set_trace_func`][set_trace_func], which imposes a large performance
penalty. **pry-nav** traces only when necessary, but due to a workaround for a
[bug in 1.9.2][ruby-bug], the console will feel sluggish. Use 1.9.3 for best
results and almost no performance penalty.


## Contributors

* Gopal Patel (@nixme)
* John Mair (@banister)
* Conrad Irwin (@ConradIrwin)
* Benjamin R. Haskell (@benizi)
* Jason R. Clark (@jasonrclark)

Patches and bug reports are welcome. Just send a [pull request][pullrequests] or
file an [issue][issues]. [Project changelog][changelog].


## Acknowledgments

- Ruby stdlib's [debug.rb][debug.rb]
- [@Mon-Ouie][Mon-Ouie]'s [pry_debug][pry_debug]


[pry-debugger]:   https://github.com/nixme/pry-debugger
[pry]:            http://pry.github.com
[pry-remote]:     https://github.com/Mon-Ouie/pry-remote
[set_trace_func]: http://www.ruby-doc.org/core-1.9.3/Kernel.html#method-i-set_trace_func
[ruby-bug]:       http://redmine.ruby-lang.org/issues/3921
[pullrequests]:   https://github.com/nixme/pry-nav/pulls
[issues]:         https://github.com/nixme/pry-nav/issues
[changelog]:      https://github.com/nixme/pry-nav/blob/master/CHANGELOG.md
[debug.rb]:       https://github.com/ruby/ruby/blob/trunk/lib/debug.rb
[Mon-Ouie]:       https://github.com/Mon-Ouie
[pry_debug]:      https://github.com/Mon-Ouie/pry_debug
[pry-byebug]:     https://github.com/deivid-rodriguez/pry-byebug
