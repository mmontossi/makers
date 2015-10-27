require 'test_helper'
require 'rails/generators'
require 'generators/makers/model/model_generator'

class GeneratorsTest < Rails::Generators::TestCase
  tests Makers::Generators::ModelGenerator
  destination File.expand_path('../tmp', File.dirname(__FILE__))

  test 'file generation' do
    run_generator %w(person)
  end

end
