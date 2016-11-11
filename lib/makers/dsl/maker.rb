module Makers
  module DSL
    class Maker

      def initialize(name, options={}, &block)
        @name = name
        @options = options.reverse_merge(class_name: name.to_s.classify)
        @class = @options[:class_name].constantize
        @assignments = {}
        if block_given?
          instance_eval &block
        end
        Makers.definitions.add(
          [@name] + Array(@options[:aliases]),
          @options,
          @assignments
        )
      end

      def maker(name, overrides={}, &block)
        options = @options.dup
        options.delete :aliases
        options.merge! overrides
        options.merge! parent: @name
        DSL::Maker.new name, options, &block
      end

      def sequence(name, &block)
        index = 0
        if block_given?
          @assignments[name] = -> {
            index += 1
            instance_exec index, &block
          }
        else
          @assignments[name] = -> {
            index += 1
          }
        end
      end

      def association(name, *args)
        options = args.extract_options!
        name = (options[:maker] || name)
        strategy = (options[:strategy] || :build)
        case @class.reflections[name.to_s].macro
        when :belongs_to,:has_one
          @assignments[name] = -> {
            maker = Makers.definitions.find(name)
            maker.send strategy
          }
        when :has_many
          @assignments[name] = -> {
            maker = Makers.definitions.find(name.to_s.singularize.to_sym)
            (args.first || 1).times.map do
              maker.send strategy
            end
          }
        end
      end

      def method_missing(name, *args, &block)
        if @class.reflections.has_key?(name.to_s)
          association name, *args
        elsif block_given?
          @assignments[name] = block
        elsif args.size > 0
          @assignments[name] = -> { args.first }
        end
      end

    end
  end
end
