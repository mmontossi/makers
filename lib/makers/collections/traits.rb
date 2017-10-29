module Makers
  module Collections
    class Traits < Base

      def add(id, &block)
        super id, block
      end

    end
  end
end
