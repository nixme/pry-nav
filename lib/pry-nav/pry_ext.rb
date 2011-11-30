require 'pry'
require 'pry-nav/tracer'

class << Pry
  alias_method :start_existing, :start

  def start(target = TOPLEVEL_BINDING, options = {})
    PryNav::Tracer.new(options) do
      start_existing(target, options.reject { |k, _| k == :pry_remote })
    end
  end
end
