module Makers
  class Railtie < Rails::Railtie

    initializer 'makers' do
      config.app_generators.test_framework(
        config.app_generators.options[:rails][:test_framework],
        fixture: false,
        fixture_replacement: :makers
      )
      if defined? RSpec
        require 'rspec/rails'
        RSpec.configure do |config|
          config.include Makers::Methods
          config.after(:each) do
            Makers.clean
          end
        end
      else
        class ActiveSupport::TestCase
          include Makers::Methods
          teardown do
            Makers.clean
          end
        end
      end
    end

    config.after_initialize do
      Makers.load
    end

  end
end
