require_relative 'transitions/to_message'

module Messaging
  class TransitionGroup
    def self.from_data(data)
      new data
    end

    def initialize(data)
      @rules = {}
      data.each do |key, value|
        @rules[key] = Transitions::ToMessage.from_data(value)
      end
    end

    def transition_for_input(input)
      rules[input['text']]
    end

    private

    attr_reader :rules
  end
end
