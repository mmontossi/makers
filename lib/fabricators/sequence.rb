module Fabricators
  class Sequence

    def initialize(&block)
      @index = 0
      @block = block
    end

    def generate(context)
      @index += 1
      if @block
        context.instance_exec @index, &@block
      else
        @index
      end
    end

  end
end
