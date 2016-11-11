module Makers
  class Maker

    attr_reader :options, :assignments, :object

    def initialize(options, assignments)
      @options = options
      @assignments = assignments
      @object = build_object
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
      hash = {}
      if options.has_key?(:parent)
        hash.merge! Makers.definitions.find(options[:parent]).attributes
      end
      assignments.keys.each do |name|
        hash[name] = object.send(name)
      end
      hash
    end

    private

    def build_one(overrides={})
      instance = options[:class_name].constantize.new
      attributes.merge(overrides).each do |name, value|
        instance.send "#{name}=", value
      end
      instance
    end

    def create_one(overrides={})
      instance = build_one(overrides)
      instance.save
      instance
    end

    def build_object
      klass = Class.new
      assignments.each do |name, logic|
        klass.send :define_method, name, &logic
      end
      klass.new
    end

  end
end
