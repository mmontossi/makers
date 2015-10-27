module Makers
  class Definitions

    def initialize
      reset
    end

    def reset
      @makers = {}
    end

    def maker(name, options={}, &block)
      maker = Maker.new(name, options, &block)
      iterate_names name, options do |name|
        @makers[name] = maker
      end
    end

    def find(name)
      @makers[name].tap do |definition|
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
