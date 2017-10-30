module Messaging
  class ValidationFailure
    def initialize(errors)
      @errors = errors
    end

    def error_name
      'validation_failure'
    end
  end
end
