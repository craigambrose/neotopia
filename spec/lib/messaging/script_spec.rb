require 'spec_helper'
require_relative 'messaging_helpers'

require 'messaging/script'

module Messaging
  describe Script do
    include MessagingHelpers
    subject { load_script(:two_messages) }

    describe '#find_message' do
      context 'for a valid script' do
        it 'can find a message' do
          message = subject.find_message 'whats_your_name?'

          expect(message).to_not be_nil
          expect(message.prompt).to eq('How exciting, and what should I call you?')
        end
      end
    end

    describe '#transition_for' do
      it 'returns transition from the current message' do
        message = subject.find_message('new_user?')
        input = {'text' => 'yes'}

        target = subject.transition_for(input: input, previous: message)

        expect(target.target_message_id).to eq('whats_your_name?')
      end
    end

    describe '#message_for_transition' do
      it 'returns the message with the target id' do
        message = subject.message_for_transition Transitions::ToMessage.new('whats_your_name?')

        expect(message).to_not be_nil
        expect(message.prompt).to eq('How exciting, and what should I call you?')
      end
    end
  end
end
