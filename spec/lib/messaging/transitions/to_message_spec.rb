require 'spec_helper'
require 'messaging/transitions/to_message'
require 'messaging/message'

module Messaging
  module Transitions
    describe ToMessage do
      describe '#apply_overrides' do
        it 'does nothing if there are no overrides' do
          message = Message.new('prompt' => 'hi there')
          subject = ToMessage.new('target', 'prompt' => 'bye')
          subject.apply_overrides message

          expect(message.prompt).to eq('bye')
        end
      end
    end
  end
end
