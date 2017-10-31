module Messaging
  module Transitions
    class ToMessage
      def self.from_data(data)
        if data.is_a?(String)
          from_string(data)
        elsif data.is_a?(Hash)
          from_hash(data)
        else
          raise ArgumentError, "Unknown transition data: #{data.inspect}"
        end
      end

      def self.from_string(string)
        new string
      end

      def self.from_hash(hash)
        raise ArgumentEror, "hash must have a \"to\" field: #{hash.inspect}" if hash['to'].blank?
        new hash['to'], hash['overrides']
      end

      def initialize(target_message_id, overrides = {})
        @target_message_id = target_message_id
        @overrides = overrides
      end

      def inspect
        "<SimpleTransition: #{@target_message_id.inspect}>"
      end

      def apply_overrides(message)
        message.apply_overrides overrides if overrides
      end

      attr_reader :target_message_id, :overrides
    end
  end
end
