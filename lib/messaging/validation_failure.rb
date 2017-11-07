module Messaging
  class ValidationFailure
    def initialize(errors = {})
      @errors = errors
    end

    def error_name
      'missing_data'
    end
  end
end
