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
      path = Rails.root.join("#{Makers.directory}/makers.rb")
      if File.exist?(path)
        load path
      end
    end

  end
end
