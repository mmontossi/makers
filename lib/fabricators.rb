require 'fabricators/callbacks'
require 'fabricators/definitions'
require 'fabricators/fabricator'
require 'fabricators/generator'
require 'fabricators/boundary'
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

  end
end
