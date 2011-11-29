require 'pry'

class << Pry
  alias_method :start_existing, :start

  def start(target = TOPLEVEL_BINDING, options = {})
    PryNav::Tracer.new(options) do
      start_existing(target, options)
    end
  end
end
