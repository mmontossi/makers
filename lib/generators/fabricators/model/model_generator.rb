require 'rails/generators/named_base'

module Fabricators
  module Generators
    class ModelGenerator < Rails::Generators::NamedBase

      source_root File.expand_path('../templates', __FILE__)

      def create_fixture_file
        template 'fabricator.rb', Fabricators.path.join("#{table_name}.rb")
      end

    end
  end
end
