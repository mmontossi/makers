module Fabricators
  class Definitions
    include Callbacks
    
    def initialize
      reset!
    end

    def reset!
      @fabricators = {}
      @generators = {}
      @callbacks = {}
    end
 
    def fabricator(name, options={}, &block)
      fabricator = Fabricator.new(name, options, &block)
      iterate_names name, options do |name|
        @fabricators[name] = fabricator
      end
    end
 
    def generator(name, first=0, options={}, &block)
      generator = Generator.new(first, &block)
      iterate_names name, options do |name|
        @generators[name] = generator
      end
    end

    def find(name, type)
      case type
      when :fabricator
        @fabricators[name]
      when :generator
        @generators[name]
      end.tap do |definition|
        raise "Definition #{name} of type #{type} not found" unless definition
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
