require 'makers/dsl/maker'
require 'makers/dsl/trait'
require 'makers/extensions/active_support/test_case'
require 'makers/definitions'
require 'makers/maker'
require 'makers/proxy'
require 'makers/railtie'
require 'makers/traits'
require 'makers/version'

module Makers
  class << self

    def definitions
      @definitions ||= Definitions.new
    end

    def traits
      @traits ||= Traits.new
    end

    def define(&block)
      Proxy.new &block
    end

  end
end
