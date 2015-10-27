module Makers
  class Maker

    attr_reader :options, :proxy

    def initialize(name, options={}, &block)
      @name = name
      @options = options
      @block = block
      @loaded = false
      Fetcher.new(name, options, &block)
    end

    def parent
      @parent ||= begin
        if @options[:parent]
          Makers.definitions.find(@options[:parent])
        end
      end
    end

    def attributes_for(options={})
      {}.tap do |hash|
        iterate_attributes(options, proxy) do |name, value|
          hash[name] = value
        end
      end
    end

    %w(build create).each do |name|
      define_method name do |*args|
        options = args.extract_options!
        single_name = :"#{name}_one"
        if args.any?
          [].tap do |list|
            args.first.times do
              list << send(single_name, options)
            end
          end
        else
          send(single_name, options)
        end
      end
    end

    %w(options attributes_for build create).each do |name|
      define_method :"#{name}_with_load" do |*args|
        load
        send :"#{name}_without_load", *args
      end
      alias_method_chain name, :load
    end

    protected

    def load
      unless @loaded
        if parent
          @options = parent.options.merge(@options)
        end
        unless @options[:class] ||= @name.to_s.classify.constantize
          raise "Class not found for maker #{@name}"
        end
        @proxy = Proxy.new(self, &@block)
        @loaded = true
      end
    end

    def build_one(options={})
      @options[:class].new.tap do |instance|
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
        if instance.save
          Makers.records << instance
        end
        trigger :after_create, instance
      end
    end

    def trigger(name, instance)
      globals = (Makers.configuration.callbacks[name] || [])
      locals = (proxy.callbacks[name] || [])
      (globals + locals).each do |callback|
        callback.call instance
      end
    end

    def iterate_attributes(options={}, context)
      proxy.attributes.merge(options).each do |name, value|
        case value
        when Proc
          context.instance_eval &value
        when Sequence
          value.generate context
        else
          value
        end.tap do |value|
          yield name, value
        end
      end
    end

  end
end