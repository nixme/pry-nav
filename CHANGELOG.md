## UNRELEASED

* Performance improvement: Don't trace while in the Pry console. Only works in
  >= 1.9.3-p0 because 1.9.2 segfaults: http://redmine.ruby-lang.org/issues/3921
* Always cleanup pry-remote DRb server and trace function when a program
  ends. Fixes [#1](https://github.com/nixme/pry-nav/issues/1).
* **step** and **next** now check for a local file context. Prevents errors and
  infinite loops when called from outside `binding.pry`, e.g. `rails console`.
* More resilient cleanup when [pry-remote][pry-remote] CLI disconnects.


## 0.0.2 (2011-11-30)

* Rudimentary [pry-remote][pry-remote] support. Still a bit buggy.
* **continue** command as an alias for **exit-all**


## 0.0.1 (2011-11-29)

* First release. Basic **step** and **next** commands.


[pry-remote]:  https://github.com/Mon-Ouie/pry-remote
