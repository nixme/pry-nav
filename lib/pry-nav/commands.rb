require 'pry'

module PryNav
  Commands = Pry::CommandSet.new do
    command 'step', 'Step execution into the next line or method.' do |steps|
      check_local_context
      breakout_navigation :step, steps
    end

    command 'next', 'Execute the next line within the same stack frame.' do |lines|
      check_local_context
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

      # Checks that a command is executed in a local file context. Extracted
      # from https://github.com/pry/pry/blob/master/lib/pry/default_commands/context.rb
      def check_local_context
        file = target.eval('__FILE__')
        if file != Pry.eval_path && (file =~ /(\(.*\))|<.*>/ || file == '' || file == '-e')
          raise Pry::CommandError, 'Cannot find local context. Did you use `binding.pry`?'
        end
      end
    end
  end
end

Pry.commands.import PryNav::Commands
