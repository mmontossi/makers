module Makers
  class Maker

    attr_reader :name, :model, :assignments, :traits, :options
    attr_accessor :disabled_association

    def initialize(name, model, assignments, traits, options)
      @name = name
      @model = model
      @assignments = assignments
      @traits = traits
      @options = options
    end

    %w(build create).each do |name|
      define_method name do |*args|
        options = args.extract_options!
        action = :"#{name}_one"
        if args.size == 1 && args.first.is_a?(Numeric)
          collection = []
          args.first.times do
            collection << send(action, options)
          end
          collection
        else
          send action, *args.append(options)
        end
      end
    end

    def attributes(traits)
      hash = merge_assignments
      traits.each do |id|
        block = find_trait(id)
        trait = Dsl::Trait.new(name, options, &block)
        hash.merge! trait.instance_variable_get(:@assignments).to_h
      end
      if disabled_association
        model.reflections.map(&:second).each do |reflection|
          if reflection.class_name == disabled_association
            hash.delete reflection.name
          end
        end
      end
      object = Object.new
      hash.each do |name, assignment|
        object.define_singleton_method name, &assignment
      end
      hash.keys.each do |name|
        hash[name] = object.send(name)
      end
      hash
    end

    def merge_assignments
      hash = assignments.to_h.dup
      if has_parent?
        hash.reverse_merge! parent.merge_assignments
      end
      hash
    end

    def find_trait(id)
      if traits.exists?(id)
        traits.get(id)
      elsif has_parent?
        parent.find_trait(id)
      elsif Makers.traits.exists?(id)
        Makers.traits.get id
      end
    end

    def has_parent?
      @options.has_key? :parent
    end

    def parent
      Makers.definitions.get @options[:parent]
    end

    private

    def build_one(*args)
      options = args.extract_options!
      instance = model.new
      attributes(args).merge(options).each do |name, value|
        instance.send "#{name}=", value
      end
      instance
    end

    def create_one(*args)
      instance = build_one(*args)
      instance.save!
      instance
    end

  end
end
