require 'json'
require_relative 'message_group'
require_relative 'transitions/script_entry'

module Messaging
  class Script
    def self.from_file(file)
      from_data(JSON.parse(file.read))
    end

    def self.from_data(data)
      new(
        data['entry'],
        data['exits'],
        MessageGroup.from_data(data['messages'])
      )
    end

    attr_reader :entry, :exits

    def initialize(entry, exits, messages)
      @entry = entry
      @exits = exits
      @messages = messages
    end

    def find_message(id)
      messages.find_message id
    end

    def transition_for(input:, command_result: nil, previous:)
      if previous
        previous.transition_for(input, command_result)
      else
        Transitions::ScriptEntry.new(self)
      end
    end

    def message_for_transition(transition)
      find_message transition.target_message_id
    end

    private

    attr_reader :messages
  end
end
