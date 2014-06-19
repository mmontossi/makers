module Fabricators
  class Railtie < Rails::Railtie

    initializer 'fabricators' do
      config.app_generators.test_framework(
        config.app_generators.options[:rails][:test_framework],
        fixture: false,
        fixture_replacement: :fabricators
      )
      if defined? RSpec
        RSpec.configure do |config|
          config.include Fabricators::Methods
          config.after(:each) do
            Fabricators.clean
          end
        end
      else
        class ActiveSupport::TestCase
          include Fabricators::Methods
          teardown do
            Fabricators.clean
          end
        end
      end
    end

    config.after_initialize do
      Fabricators.load_files
    end

  end
end
