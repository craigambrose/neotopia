require 'spec_helper'
require_relative 'messaging_helpers'

require 'messaging/message'

module Messaging
  describe Message do
    include MessagingHelpers

    describe '#transition_target' do
      context 'for a valid script' do
        it 'returns the id matching text input' do
          message = load_message(:two_messages, 'new_user?')
          input = {'text' => 'yes'}

          target = message.transition_for_input(input)

          expect(target.target_message_id).to eq('whats_your_name?')
        end
      end
    end
  end
end
