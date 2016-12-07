module Makers
  class Definitions

    def find(name)
      if registry.has_key?(name)
        registry[name]
      else
        raise "Definition #{name} not found"
      end
    end

    def add(names, *args)
      maker = Maker.new(*args)
      names.each do |name|
        if registry.has_key?(name)
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
