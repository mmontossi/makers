module Fabricators
  class Definitions
    include Callbacks
 
    def initialize
      reset!
    end

    def reset!
      @fabricators = {}
      @attributes = {}
      @callbacks = {}
    end
 
    def fabricator(name, options={}, &block)
      fabricator = Fabricator.new(name, options, &block)
      iterate_names name, options do |name|
        @fabricators[name] = fabricator
      end
    end
 
    def attribute(name, options={}, &block)
      attribute = Attribute.new(&block)
      iterate_names name, options do |name|
        @attributes[name] = attribute
      end
    end

    def find(name, type)
      case type
      when :fabricator
        @fabricators[name]
      when :attribute
        @attributes[name]
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
