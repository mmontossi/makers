require 'test_helper'
require 'rails/generators'
require 'generators/fabricators/model/model_generator'

class GeneratorsTest < Rails::Generators::TestCase
  tests Fabricators::Generators::ModelGenerator
  destination File.expand_path('../tmp', File.dirname(__FILE__))

  test 'file generation' do
    run_generator %w(person)
  end

end
