module Messaging
  class Interpolator
    REGEX = /\{\{([^}]+)}\}/

    def initialize(context)
      @context = context
    end

    def interpolate(input)
      input.gsub(REGEX) do
        context.read_value Regexp.last_match[1]
      end
    end

    private

    attr_reader :context
  end
end
