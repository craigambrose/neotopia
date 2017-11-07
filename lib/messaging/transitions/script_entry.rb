module Messaging
  module Transitions
    class ScriptEntry
      attr_reader :script

      def initialize(script)
        @script = script
      end

      def target_message_id
        script.entry
      end

      def apply_overrides(message)
        message
      end

      def get_message(script)
        script.find_message target_message_id
      end
    end
  end
end
