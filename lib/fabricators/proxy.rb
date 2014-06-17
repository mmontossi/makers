module Fabricators
  class Proxy
    include Callbacks

    def initialize(name, parent, &block)
      @name = name
      @parent = parent
      @attributes = []
      instance_eval &block
    end

    def attributes
      {}.tap do |hash|
        if @parent
          hash.merge! Fabricators.definitions.find(@parent, :fabricator).proxy.attributes
        end
        @attributes.each do |name|
          hash[name] = send(name)
        end
      end
    end

    def method_missing(name, *args, &block)
      unless name == :fabricator
        if block_given?
          @attributes.push name
          class_eval do
            define_method(name) { block }
          end
        elsif fabricator = Fabricators.definitions.find(name, :fabricator) rescue nil
          @attributes.push name
          options = args.extract_options!
          strategy = options.delete(:strategy) || :build
          class_eval do
            define_method(name) { fabricator.send(strategy, options) }
          end
        elsif fabricator = Fabricators.definitions.find(name.to_s.singularize.to_sym, :fabricator) rescue nil
          @attributes.push name
          options = args.extract_options!
          strategy = options.delete(:strategy) || :build
          class_eval do
            define_method(name) { fabricator.send(strategy, (args.first || 1), options) }
          end
        elsif generator = Fabricators.definitions.find(name, :generator) rescue nil
          @attributes.push name
          class_eval do
            define_method(name) { generator.generate }
          end
        elsif args.any?
          @attributes.unshift name
          class_eval do
            define_method(name) { args.first }
          end
        end
      end
    end
 
  end
end
