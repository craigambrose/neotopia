require 'spec_helper'
require_relative 'messaging_helpers'

require 'messaging/exchange'

module Messaging
  describe Exchange do
    include MessagingHelpers

    describe '#determine_response' do
      context 'with a single script' do
        let(:script) { load_script(:two_messages) }
        subject { Exchange.new(script: script) }

        it 'find the next message for simple text input' do
          subject.user_input to: 'new_user?', input: { 'text' => 'yes' }
          message = subject.determine_response

          expect(message.id).to eq('whats_your_name?')
        end

        it 'find the entry message if no input is supplied' do
          message = subject.determine_response

          expect(message.id).to eq('new_user?')
        end
      end
    end
  end
end
