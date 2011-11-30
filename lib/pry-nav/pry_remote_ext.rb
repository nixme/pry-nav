require 'pry-remote'

module PryRemote

  # Extraction of Object#remote_pry from
  # https://github.com/Mon-Ouie/pry-remote/blob/master/lib/pry-remote.rb
  # into separate `start` and `stop` methods so that a DRb session can last over
  # multiple Pry.start calls.
  module Server
    extend self

    def start(host, port)
      uri = "druby://#{host}:#{port}"

      @client = PryRemote::Client.new
      DRb.start_service uri, @client

      puts "[pry-remote] Waiting for client on #{uri}"
      @client.wait

      # If client passed stdout and stderr, redirect actual messages there.
      @old_stdout, $stdout =
        if @client.stdout
          [$stdout, @client.stdout]
        else
          [$stdout, $stdout]
        end

      @old_stderr, $stderr =
        if @client.stderr
          [$stderr, @client.stderr]
        else
          [$stderr, $stderr]
        end

      # Before Pry starts, save the pager config.
      # We want to disable this because the pager won't do anything useful in
      # this case (it will run on the server).
      Pry.config.pager, @old_pager = false, Pry.config.pager

      # As above, but for system config
      Pry.config.system, @old_system = PryRemote::System, Pry.config.system

      @client
    end

    def stop
      # Reset output streams
      $stdout = @old_stdout
      $stderr = @old_stderr

      # Reset config
      Pry.config.pager = @old_pager

      # Reset system
      Pry.config.system = @old_system

      puts "[pry-remote] Remote sesion terminated"
      @client.kill

      DRb.stop_service
    end
  end
end

class Object
  # Override pry-remote's Object#remote_pry to use the above
  # PryRemote::Server. The PryNav::Tracer instance is responsible for
  # terminating the DRb server by calling PryRemote::Server#stop
  def remote_pry(host = 'localhost', port = 9876)
    client = PryRemote::Server.start(host, port)
    Pry.start self, {
      :input => client.input_proxy,
      :output => client.output,
      :pry_remote => true
    }
  end
end
