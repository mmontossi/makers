require 'fabricators/callbacks'
require 'fabricators/definitions'
require 'fabricators/fabricator'
require 'fabricators/attribute'
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

    def clean
      records.pop.destroy until records.empty?
    end

    def records
      @records ||= []
    end

    def definitions
      @definitions ||= Definitions.new
    end

    def path
      @path ||= %w(test spec).map{ |dir| Rails.root.join(dir) }.find{ |path| Dir.exist?(path) }.try(:join, 'fabricators')
    end

    def load_files
      if path
        Dir[path.join('**', '*.rb')].each do |file|
          Fabricators.definitions.instance_eval File.read(file)
        end
      end
    end

  end
end
