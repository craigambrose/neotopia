require_relative 'message'

module Messaging
  class MessageGroup
    def self.from_data(data)
      hashed_messages = {}
      data.each do |message_data|
        hashed_messages[message_data['id']] = Message.from_data(message_data)
      end

      new hashed_messages
    end

    def initialize(hashed_messages)
      @messages = hashed_messages
    end

    def find_message(id)
      messages[id]
    end

    private

    attr_reader :messages
  end
end
