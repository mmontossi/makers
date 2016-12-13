module Makers
  class Definitions

    def find(id)
      if registry.has_key?(id)
        registry[id]
      else
        raise "Definition #{id} not found"
      end
    end

    def add(ids, *args)
      maker = Maker.new(*args)
      ids.each do |id|
        if registry.has_key?(id)
          raise "Maker #{id} already registered"
        else
          registry[id] = maker
        end
      end
    end

    private

    def registry
      @registry ||= {}
    end

  end
end
