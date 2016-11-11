module Makers
  class Definitions

    def contains?(name)
      registry.has_key? name
    end

    def find(name)
      if contains?(name)
        registry[name]
      else
        raise "Definition #{name} not found"
      end
    end

    def add(names, *args)
      maker = Maker.new(*args)
      names.each do |name|
        if contains?(name)
          raise "Maker #{name} already registered"
        else
          registry[name] = maker
        end
      end
    end

    private

    def registry
      @registry ||= {}
    end

  end
end
