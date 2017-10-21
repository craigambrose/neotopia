module Messaging
  module Transitions
    class ToMessage
      def self.from_data(data)
        raise ArgumentError, 'currently only supports a single string' unless data.is_a? String
        new data
      end

      def initialize(target_message_id)
        @target_message_id = target_message_id
      end

      def inspect
        "<SimpleTransition: #{@target_message_id.inspect}>"
      end

      attr_reader :target_message_id
    end
  end
end
