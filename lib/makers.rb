require 'makers/errors'
require 'makers/collections/base'
require 'makers/collections/assignments'
require 'makers/collections/definitions'
require 'makers/collections/traits'
require 'makers/dsl/trait'
require 'makers/dsl/maker'
require 'makers/extensions/active_support/test_case'
require 'makers/maker'
require 'makers/proxy'
require 'makers/railtie'
require 'makers/version'

module Makers
  class << self

    def definitions
      @definitions ||= Collections::Definitions.new
    end

    def traits
      @traits ||= Collections::Traits.new
    end

    def directory
      if Dir.exist?(Rails.root.join('test'))
        'test'
      else
        'spec'
      end
    end

    def define(&block)
      Proxy.new &block
    end

  end
end
