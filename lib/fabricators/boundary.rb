module Fabricators
  class Boundary

    def initialize(name, options, &block)
      @name = name
      @options = options
      instance_eval &block
    end
    
    def fabricator(name, options={}, &block)
      Fabricators.definitions.fabricator name, @options.merge(options.merge(parent: @name)), &block
    end

    def method_missing(name, *args, &block)
    end

  end
end
