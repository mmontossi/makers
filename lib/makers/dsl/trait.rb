module Makers
  module Dsl
    class Trait

      def initialize(name, options={}, &block)
        class_name = options[:class_name] ||= name.to_s.classify
        @model = class_name.constantize
        @name = name
        @assignments = Collections::Assignments.new
        @options = options
        if block_given?
          instance_eval &block
        end
      end

      def sequence(name, &block)
        index = 0
        if block_given?
          logic = -> {
            index += 1
            instance_exec index, &block
          }
        else
          logic = -> { index += 1 }
        end
        @assignments.add name, &logic
      end

      def association(name, *args)
        options = args.extract_options!
        lookup = (options[:maker] || name)
        action = (options[:strategy] || :build)
        model = @model
        case model.reflections[name.to_s].macro
        when :belongs_to,:has_one
          logic = -> {
            maker = Makers.definitions.get(lookup).dup
            maker.disabled_association = model.name
            maker.send action
          }
        when :has_many
          logic = -> {
            maker = Makers.definitions.get(lookup.to_s.singularize.to_sym).dup
            maker.disabled_association = model.name
            (args.first || 1).times.map do
              maker.send action
            end
          }
        end
        @assignments.add name, &logic
      end

      def method_missing(name, *args, &block)
        if @model.reflections.has_key?(name.to_s)
          association name, *args
        else
          if block_given?
            logic = -> { instance_eval &block }
          else
            logic = -> { args.first }
          end
          @assignments.add name, &logic
        end
      end

    end
  end
end
