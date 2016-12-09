module Makers
  class Railtie < Rails::Railtie

    initializer 'makers.extensions' do
      ActiveSupport::TestCase.include(
        Makers::Extensions::ActiveSupport::TestCase
      )
    end

    initializer 'makers.test_framework' do
      config.app_generators.test_framework(
        config.app_generators.options[:rails][:test_framework],
        fixture: false
      )
    end

    config.after_initialize do
      if Dir.exist?(Rails.root.join('spec'))
        directory = 'spec'
      else
        directory = 'test'
      end
      path = Rails.root.join("#{directory}/makers.rb")
      if File.exist?(path)
        load path
      end
    end

  end
end
