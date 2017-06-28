require 'rails/generators'

module Makers
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def create_definitions_file
        template 'definitions.rb', "#{Makers.directory}/makers.rb"
      end

    end
  end
end
