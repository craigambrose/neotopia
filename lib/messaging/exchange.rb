require_relative 'script'

module Messaging
  class Exchange
    def initialize(script:)
      @script = script
      @previous_message = nil
      @input = nil
    end

    def user_input(to:, input:)
      @previous_message = script.find_message(to)
      @input = input
    end

    def determine_response
      target = script.transition_for_input input: input, previous: previous_message
      script.message_for_transition target
    end

    private

    attr_reader :script, :previous_message, :input
  end
end
