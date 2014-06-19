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
      @path ||= begin
        %w(test spec).each do |dir|
          path = Rails.root.join(dir, 'fabricators')
          if Dir.exist? path.dirname
            unless Dir.exist? path
              Dir.mkdir path 
            end
            return path
          end
        end
      end
    end

    def load_files
      Dir[path.join('**', '*.rb')].each do |file|
        Fabricators.definitions.instance_eval File.read(file)
      end
    end

  end
end
