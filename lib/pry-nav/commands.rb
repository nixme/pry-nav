require 'pry'

module PryNav
  Commands = Pry::CommandSet.new do
    command 'step', 'Step execution into the next line or method.' do |steps|
      breakout_navigation :step, steps
    end

    command 'next', 'Execute the next line within the same stack frame.' do |lines|
      breakout_navigation :next, lines
    end

    command 'continue', 'Continue program execution and end the Pry session.' do
      run 'exit-all'
    end

    alias_command 'n', 'next'
    alias_command 's', 'step'
    alias_command 'c', 'continue'

    helpers do
      def breakout_navigation(action, times)
        _pry_.binding_stack.clear     # Clear the binding stack.
        throw :breakout_nav, {        # Break out of the REPL loop and
          action: action,             #   signal the tracer.
          times:  times
        }
      end
    end
  end
end

Pry.commands.import PryNav::Commands
