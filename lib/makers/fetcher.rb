module Makers
  class Fetcher

    def initialize(name, options, &block)
      @name = name
      @options = options
      instance_eval &block
    end

    def maker(name, options={}, &block)
      Makers.definitions.maker name, @options.merge(options.merge(parent: @name)), &block
    end

    def method_missing(name, *args, &block)
    end

  end
end
