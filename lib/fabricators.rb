require 'fabricators/callbacks'
require 'fabricators/definitions'
require 'fabricators/fabricator'
require 'fabricators/generator'
require 'fabricators/reader'
require 'fabricators/proxy'
require 'fabricators/methods'
require 'fabricators/railtie'

module Fabricators
  extend Methods
  class << self

    def define(&block)
      definitions.instance_eval &block
    end

    def definitions
      @definitions ||= Definitions.new
    end
 
    def generate(name)
      definitions.find(name, :generator).generate
    end

    def paths
      @paths ||= %w(test/fabricators spec/fabricators).map { |path| Rails.root.join(path) }
    end

    def path
      @path ||= paths.find { |path| Dir.exists? path }
    end

    def populate
      Dir[path.join('**', '*.rb')].each do |file|
        load file
      end
    end

  end
end
