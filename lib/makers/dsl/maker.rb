module Makers
  module Dsl
    class Maker < Trait

      def initialize(name, options={}, &block)
        @traits = Collections::Traits.new
        super
      end

      def maker(name, overrides={}, &block)
        options = @options.dup
        options.delete :aliases
        options.merge! overrides
        options.merge! parent: @name
        Makers.definitions.add Dsl::Maker.new(name, options, &block)
      end

      def trait(name, &block)
        @traits.add name, &block
      end

    end
  end
end
