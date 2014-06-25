module Fabricators
  module Callbacks

    def callbacks
      @callbacks ||= {}
    end

    %w(after before).each do |moment|
      define_method moment do |actions, &block|
        actions = [actions] unless actions.is_a? Array
        actions.each do |action|
          name = :"#{moment}_#{action}"
          if callbacks[name]
            callbacks[name] << block
          else
            callbacks[name] = [block]
          end
        end
      end
    end

  end
end
