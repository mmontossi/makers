require 'makers/dsl/maker'
require 'makers/extensions/active_support/test_case'
require 'makers/definitions'
require 'makers/maker'
require 'makers/proxy'
require 'makers/railtie'
require 'makers/version'

module Makers
  class << self

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end

    def definitions
      @definitions ||= Definitions.new
    end

    def define(&block)
      Proxy.new &block
    end

  end
end
