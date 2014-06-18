module Fabricators
  class Railtie < Rails::Railtie

    initializer 'fabricators' do
      test_framework = config.app_generators.options[:rails][:test_framework]
      config.app_generators.test_framework test_framework, fixture: false, fixture_replacement: :fabricators
    end

    config.after_initialize do
      Fabricators.load_files
    end

  end
end
