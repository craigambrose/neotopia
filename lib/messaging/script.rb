require 'json'
require_relative 'message_group'

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

    def initialize(entry, exits, messages)
      @entry = entry
      @exits = exits
      @messages = messages
    end

    def find_message(id)
      messages.find_message id
    end

    private

    attr_reader :entry, :exits, :messages
  end
end
