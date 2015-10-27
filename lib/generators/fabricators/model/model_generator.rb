require 'rails/generators/named_base'

module Makers
  module Generators
    class ModelGenerator < Rails::Generators::NamedBase

      source_root File.expand_path('../templates', __FILE__)

      def create_fixture_file
        template 'maker.rb', Makers.path.join("#{table_name}.rb")
      end

    end
  end
end
