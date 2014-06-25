module Fabricators
  class Definitions

    def initialize
      reset
    end

    def reset
      @fabricators = {}
    end

    def fabricator(name, options={}, &block)
      fabricator = Fabricator.new(name, options, &block)
      iterate_names name, options do |name|
        @fabricators[name] = fabricator
      end
    end

    def find(name)
      @fabricators[name].tap do |definition|
        raise "Definition #{name} not found" unless definition
      end
    end

    protected

    def iterate_names(name, options)
      names = [name]
      if aliases = options[:aliases]
        case aliases
        when Array
          names |= aliases
        else
          names << aliases
        end
      end
      names.each do |name|
        yield name
      end
    end

  end
end
