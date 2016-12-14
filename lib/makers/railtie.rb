module Makers
  class Railtie < Rails::Railtie

    config.app_generators.test_framework(
      config.app_generators.options[:rails][:test_framework],
      fixture: false
    )

    initializer 'makers.active_support' do
      ActiveSupport::TestCase.include(
        Makers::Extensions::ActiveSupport::TestCase
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
