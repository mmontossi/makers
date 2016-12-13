module Makers
  class Traits

    def find(id)
      if registry.has_key?(id)
        registry[id]
      else
        raise "Trait #{id} not found"
      end
    end

    def add(id, block)
      if registry.has_key?(id)
        raise "Trait #{id} already registered"
      else
        registry[id] = block
      end
    end

    private

    def registry
      @registry ||= {}
    end

  end
end
