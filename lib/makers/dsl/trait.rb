module Makers
  module Dsl
    class Trait

      def initialize(name, &block)
        Makers.traits.add name, block
      end

    end
  end
end
