module Makers
  module Collections
    class Base

      def exists?(id)
        registry.has_key? id
      end

      def to_h
        registry
      end

      def get(id)
        if exists?(id)
          registry[id]
        else
          raise error('NotFound')
        end
      end

      def add(id, value)
        if exists?(id)
          raise error('AlreadyExists')
        else
          registry[id] = value
        end
      end

      private

      def registry
        @registry ||= {}
      end

      def error(suffix)
        Errors.const_get("#{self.class.name.singularize.demodulize}#{suffix}")
      end

    end
  end
end
