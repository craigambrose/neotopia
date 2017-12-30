module Messaging
  class ValidationFailure
    def initialize(name = 'missing_data', errors = {})
      Rails.logger.debug "validation failure with: #{errors.inspect}"
      @error_name = name
      @errors = errors
    end

    attr_reader :error_name
  end
end
