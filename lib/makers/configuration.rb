module Makers
  class Configuration
    include Callbacks

    def reset
      @callbacks = {}
    end

  end
end
