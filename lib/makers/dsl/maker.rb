module Makers
  module Dsl
    class Maker

      def initialize(name, options={}, &block)
        class_name = options[:class_name] ||= name.to_s.classify
        @model = class_name.constantize
        @name = name
        @assignments = {}
        @associations = {}
        @sequences = {}
        @options = options
        if block_given?
          instance_eval &block
        end
        Array(options[:traits]).each do |id|
          block = Makers.traits.find(id)
          instance_eval &block
        end
        Makers.definitions.add(
          [name] + Array(options[:aliases]),
          @name,
          @model,
          @assignments,
          @associations,
          @sequences,
          @options
        )
      end

      def maker(name, overrides={}, &block)
        options = @options.dup
        options.delete :aliases
        options.delete :traits
        options.merge! overrides
        options.merge! parent: @name
        Dsl::Maker.new name, options, &block
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
        @sequences[name] = index
      end

      def association(name, *args)
        options = args.extract_options!
        lookup = (options[:maker] || name)
        action = (options[:strategy] || :build)
        reflection = @model.reflections[name.to_s]
        class_name = @model.name
        case reflection.macro
        when :belongs_to,:has_one
          @assignments[name] = -> {
            maker = Makers.definitions.find(lookup).dup
            maker.disabled_association = class_name
            maker.send action
          }
        when :has_many
          @assignments[name] = -> {
            maker = Makers.definitions.find(lookup.to_s.singularize.to_sym).dup
            maker.disabled_association = class_name
            (args.first || 1).times.map do
              maker.send action
            end
          }
        end
        @associations[name] = reflection.class_name
      end

      def method_missing(name, *args, &block)
        if @model.reflections.has_key?(name.to_s)
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
