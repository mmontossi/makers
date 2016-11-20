module Makers
  module Extensions
    module ActiveSupport
      module TestCase
        extend ActiveSupport::Concern

        %w(build create).each do |method|
          define_method method do |name, *args|
            Makers.definitions.find(name).send method, *args
          end
        end

      end
    end
  end
end
