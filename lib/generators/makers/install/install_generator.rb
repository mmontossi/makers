require 'rails/generators'

module Makers
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def create_definitions_file
        if Dir.exist?(Rails.root.join('spec'))
          directory = 'spec'
        else
          directory = 'test'
        end
        template 'definitions.rb', "#{directory}/makers.rb"
      end

    end
  end
end
