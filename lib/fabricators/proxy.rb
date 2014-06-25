module Fabricators
  class Proxy
    include Callbacks

    def initialize(fabricator, &block)
      @fabricator = fabricator
      @attributes = []
      @sequences = {}
      instance_eval &block
    end

    def attributes
      {}.tap do |hash|
        if @fabricator.parent
          hash.merge! @fabricator.parent.proxy.attributes
        end
        @attributes.each do |name|
          hash[name] = send(name)
        end
      end
    end

    def sequence(name, &block)
      @attributes << name
      @sequences[name] = Sequence.new(&block)
      class_eval do
        define_method(name) { @sequences[name] }
      end
    end

    def method_missing(name, *args, &block)
      unless name == :fabricator
        options = args.extract_options!
        strategy = options.delete(:strategy) || :build
        if block_given?
          logic = block
        elsif fabricator = Fabricators.definitions.find(name) rescue nil
          logic = -> { fabricator.send(strategy, options) }
        elsif fabricator = Fabricators.definitions.find(name.to_s.singularize.to_sym) rescue nil
          logic = -> { fabricator.send(strategy, (args.first || 1), options) }
        elsif args.any?
          logic = -> { args.first }
        end
        if defined? logic
          @attributes.send (block_given? ? :push : :unshift), name
          class_eval { define_method(name, logic) }
        end
      end
    end

  end
end
