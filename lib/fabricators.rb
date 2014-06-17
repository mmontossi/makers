require 'fabricators/callbacks'
require 'fabricators/definitions'
require 'fabricators/fabricator'
require 'fabricators/generator'
require 'fabricators/reader'
require 'fabricators/proxy'
require 'fabricators/methods'

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

  end
end
