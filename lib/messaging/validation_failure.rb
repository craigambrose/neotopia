module Messaging
  class ValidationFailure
    def initialize(errors = {})
      Rails.logger.debug "validation failure with: #{errors.inspect}"
      @errors = errors
    end

    def error_name
      'missing_data'
    end
  end
end
