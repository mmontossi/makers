module Makers
  class Maker

    attr_reader :name, :model, :assignments, :associations, :sequences, :options
    attr_accessor :disabled_association

    def initialize(name, model, assignments, associations, sequences, options)
      @name = name
      @model = model
      @assignments = assignments
      @associations = associations
      @sequences = sequences
      @options = options
    end

    %w(build create).each do |name|
      define_method name do |*args|
        options = args.extract_options!
        action = :"#{name}_one"
        if args.any?
          collection = []
          args.first.times do
            collection << send(action, options)
          end
          collection
        else
          send action, options
        end
      end
    end

    def attributes
      all = assignments.dup
      if options.has_key?(:parent)
        all.reverse_merge! Makers.definitions.find(options[:parent]).assignments
      end
      if disabled_association
        associations.each do |name, class_name|
          if disabled_association == class_name
            all[name] = -> { nil }
          end
        end
      end
      object = Object.new
      all.each do |name, block|
        object.define_singleton_method name, &block
      end
      hash = {}
      all.keys.each do |name|
        hash[name] = object.send(name)
      end
      hash
    end

    private

    def build_one(overrides={})
      instance = model.new
      attributes.merge(overrides).each do |name, value|
        instance.send "#{name}=", value
      end
      instance
    end

    def create_one(overrides={})
      instance = build_one(overrides)
      instance.save!
      instance
    end

  end
end
