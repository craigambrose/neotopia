module Messaging
  class Message
    def self.from_data(data)
      new data
    end

    def initialize(data)
      @id = data['id']
      @prompt = data['prompt']
      @responder = data['responder']
      @transitions = data['transitions']
    end

    attr_reader :id, :prompt, :responder, :transitions
  end
end
