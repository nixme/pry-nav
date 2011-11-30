require 'pry'

module PryNav
  class Tracer
    FILE = File.expand_path(__FILE__)

    def initialize(pry_start_options = {}, &block)
      @step_in_lines = -1                      # Break after this many lines
      @frames_when_stepping = nil              # Only break at this frame level
      @frames = []                             # Traced stack frames
      @pry_start_options = pry_start_options   # Options to use for Pry.start

      run &block
    end

    def run(&block)
      start    # Set the trace function

      return_value = nil
      command = catch(:breakout_nav) do      # Coordinate with PryNav::Commands
        return_value = yield
        {}    # Nothing thrown == no navigational command
      end

      process_command command

      return_value
    end

    def start
      set_trace_func method(:tracer).to_proc
    end

    def stop
      set_trace_func nil
    end

    def process_command(command = {})
      times = (command[:times] || 1).to_i
      times = 1 if times <= 0

      case command[:action]
      when :step
        @step_in_lines = times
        @frames_when_stepping = nil
      when :next
        @step_in_lines = times
        @frames_when_stepping = @frames.size
      else
        stop
        PryRemote::Server.stop if @pry_start_options[:pry_remote]
      end
    end


   private

    def tracer(event, file, line, id, binding, klass)
      # Ignore traces inside pry-nav code
      return if (file && File.expand_path(file) == FILE)

      case event
      when 'line'
        # Are we stepping? Or continuing by line ('next') and we're at the right
        # frame? Then decrement our line counter cause this line counts.
        if !@frames_when_stepping || @frames.size == @frames_when_stepping
          @step_in_lines -= 1
          @step_in_lines = -1 if @step_in_lines < 0

        # Did we go up a frame and not break for a 'next' yet?
        elsif @frames.size < @frames_when_stepping
          @step_in_lines = 0   # Break right away
        end

        # Break on this line?
        Pry.start(binding, @pry_start_options) if @step_in_lines == 0

      when 'call', 'class'
        @frames.unshift [binding, file, line, id]   # Track entering a frame

      when 'return', 'end'
        @frames.shift                          # Track leaving a stack frame
      end
    end
  end
end
