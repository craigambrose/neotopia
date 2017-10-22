module Messaging
  class Interpolator
    def initialize(context)
      @context = context
    end

    def interpolate(input)
      input
    end

    private

    attr_reader :context
  end
end
