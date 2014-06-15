module Fabricators
  module Methods

    %w(build create attributes_for).each do |method|
      define_method method do |name, *args|
        Fabricators.definitions.find(name, :fabricator).send(method, *args)
      end
    end
 
    def generate(name)
      Fabricators.definitions.find(name, :generator).generate
    end

  end
end
