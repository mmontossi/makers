require 'fabricators/callbacks'
require 'fabricators/definitions'
require 'fabricators/configuration'
require 'fabricators/fabricator'
require 'fabricators/sequence'
require 'fabricators/fetcher'
require 'fabricators/proxy'
require 'fabricators/methods'
require 'fabricators/railtie'

module Fabricators
  extend Methods
  class << self

    def reset
      configuration.reset
      definitions.reset
    end

    def configure(&block)
      configuration.instance_eval &block
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def define(&block)
      definitions.instance_eval &block
    end

    def definitions
      @definitions ||= Definitions.new
    end

    def clean
      records.pop.destroy until records.empty?
    end

    def records
      @records ||= []
    end

    def load_files
      if path
        Dir[path.join('**', '*.rb')].each do |file|
          definitions.instance_eval File.read(file)
        end
      end
    end

    def path
      @path ||= %w(test spec).map{ |dir| Rails.root.join(dir) }.find{ |path| Dir.exist?(path) }.try(:join, 'fabricators')
    end

  end
end
