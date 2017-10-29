module Makers
  module Collections
    class Definitions < Base

      def add(maker)
        args = []
        %i(name model assignments traits options).each do |name|
          args << maker.instance_variable_get("@#{name}")
        end
        maker = Maker.new(*args)
        Array(args.last[:aliases]).prepend(args.first).each do |id|
          super id, maker
        end
      end

    end
  end
end
