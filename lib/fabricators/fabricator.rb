module Fabricators
  class Fabricator

    attr_reader :proxy

    def initialize(name, options={}, &block)
      @options = options
      @parent = @options[:parent]
      @class = @options[:class] ||= name.to_s.classify.constantize
      raise "Class not found #{name}" unless @class
      @proxy = Proxy.new(name, options, &block)
    end

    def attributes_for(options={})
      proxy.load
      {}.tap do |hash|
        iterate_attributes(options, proxy) do |name, value|
          hash[name] = value
        end
      end
    end

    %w(build create).each do |action|
      define_method action do |*args|
        proxy.load
        options = args.extract_options!
        method = :"#{action}_one"
        if args.any?
          [].tap do |list|
            args.first.times do
              list << send(method, options)
            end
          end
        else
          send(method, options)
        end
      end
    end

    protected

    def build_one(options={})
      @class.new.tap do |instance|
        trigger :before_build, instance
        iterate_attributes(options, instance) do |name, value|
          instance.send :"#{name}=", value
        end
        trigger :after_build, instance
      end
    end

    def create_one(options={})
      build_one(options).tap do |instance|
        trigger :before_create, instance
        instance.save
        trigger :after_create, instance
      end
    end

    def trigger(name, instance)
      globals = (Fabricators.definitions.callbacks[name] || [])
      locals = (proxy.callbacks[name] || [])
      (globals + locals).each do |callback|
        callback.call instance
      end
    end

    def iterate_attributes(options={}, context)
      proxy.attributes.merge(options).each do |name, value|
        yield name, (value.is_a?(Proc) ? context.instance_eval(&value) : value)
      end
    end

  end
end
