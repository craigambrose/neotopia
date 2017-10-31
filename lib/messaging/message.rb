require_relative 'transition_group'

module Messaging
  class Message
    def self.from_data(data)
      new data
    end

    def initialize(data)
      @id = data['id']
      @prompt = data['prompt']
      @responder = data['responder']
      @transitions = TransitionGroup.from_data(data['transitions'])
      @command = data['command']
    end

    attr_reader :id, :responder, :transitions
    attr_accessor :prompt

    def transition_for(input, command_result = nil)
      transitions.transition_for(input, command_result)
    end

    def command_name
      command
    end

    def as_json(interpolator = nil)
      {
        id: id,
        prompt: interpolator ? interpolated_prompt(interpolator) : prompt,
        responder: responder
      }
    end

    def apply_overrides(overrides)
      overrides.each do |key, value|
        send("#{key}=", value)
      end
    end

    private

    attr_reader :command

    def interpolated_prompt(interpolator)
      interpolator.interpolate prompt
    end
  end
end
