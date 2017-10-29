module Makers
  module Errors
    class Base < StandardError
    end

    class AssignmentNotFound < Base
    end

    class AssignmentAlreadyExists < Base
    end

    class DefinitionNotFound < Base
    end

    class DefinitionAlreadyExists < Base
    end

    class TraitNotFound < Base
    end

    class TraitAlreadyExists< Base
    end
  end
end
