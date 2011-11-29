pry-nav
=======

_Simple execution control in Pry_

Adds **step** and **next** commands to your [Pry][pry]
console. Makes for a simple but ghetto debugger.

Note: In order to get the correct flow control, `Pry.start` is overriden. Use at
your own risk.


## Acknowledgments

- Ruby stdlib [debug.rb][debug.rb]
- [@Mon-Ouie][Mon-Ouie]'s [pry_debug][pry_debug]


## TODO

- Thread safety
- Compatibility with [pry-remote][pry-remote]


[pry]:         http://pry.github.com
[debug.rb]:    https://github.com/ruby/ruby/blob/trunk/lib/debug.rb
[Mon-Ouie]:    https://github.com/Mon-Ouie
[pry_debug]:   https://github.com/Mon-Ouie/pry_debug
[pry-remote]:  https://github.com/Mon-Ouie/pry-remote
