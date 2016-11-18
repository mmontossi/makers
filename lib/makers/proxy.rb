module Makers
  class Proxy

    def initialize(&block)
      instance_eval &block
    end

    def maker(*args, &block)
      Dsl::Maker.new *args, &block
    end

  end
end
