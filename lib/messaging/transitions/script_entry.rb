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
    end
  end
end
