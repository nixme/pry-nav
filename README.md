pry-nav
=======

_Simple execution control in Pry_

Adds **step**, **next**, and **continue** commands to your [Pry][pry]
console. Makes for a simple but ghetto debugger.

Rudimentary support for [pry-remote][pry-remote] is included. Ensure pry-remote
is loaded or required before pry-nav. For example, in a Gemfile:

```ruby
gem 'pry'
gem 'pry-remote'
gem 'pry-nav'
```

Note: In order to get correct flow control, `Pry.start` is overriden. Use at
your own risk.


## Acknowledgments

- Ruby stdlib's [debug.rb][debug.rb]
- [@Mon-Ouie][Mon-Ouie]'s [pry_debug][pry_debug]


## TODO

- Thread safety


[pry]:         http://pry.github.com
[debug.rb]:    https://github.com/ruby/ruby/blob/trunk/lib/debug.rb
[Mon-Ouie]:    https://github.com/Mon-Ouie
[pry_debug]:   https://github.com/Mon-Ouie/pry_debug
[pry-remote]:  https://github.com/Mon-Ouie/pry-remote
