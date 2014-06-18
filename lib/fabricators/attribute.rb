module Fabricators
  class Attribute

    def initialize(&block)
      @index = 0
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
