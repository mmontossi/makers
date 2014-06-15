module Fabricators
  class Generator

    def initialize(starts_at, &block)
      @index = starts_at
      @block = block
    end

    def generate
      @index += 1
      if @block
        @block.call(@index)
      else
        @index
      end
    end

  end
end
