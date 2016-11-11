module Makers
  class Railtie < Rails::Railtie

    initializer :makers do
      config.app_generators.test_framework(
        config.app_generators.options[:rails][:test_framework],
        fixture: false
      )
      if Dir.exist?(Rails.root.join('spec'))
        directory = 'spec'
      else
        directory = 'test'
      end
      path = Rails.root.join("#{directory}/makers.rb")
      if File.exist?(path)
        load path
      end
      ActiveSupport::TestCase.include Makers::Extensions::ActiveSupport::TestCase
    end

  end
end
