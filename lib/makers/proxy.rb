module Makers
  class Proxy

    def initialize(&block)
      instance_eval &block
    end

    def maker(*args, &block)
      Makers.definitions.add Dsl::Maker.new(*args, &block)
    end

    def trait(*args, &block)
      Makers.traits.add *args, &block
    end

  end
end
