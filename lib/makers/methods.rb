module Makers
  module Methods

    %w(build create attributes_for).each do |method|
      define_method method do |name, *args|
        Makers.definitions.find(name).send(method, *args)
      end
    end

  end
end
