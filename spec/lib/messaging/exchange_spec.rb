require 'spec_helper'
require_relative 'messaging_helpers'
require 'messaging/exchange'

module Messaging
  describe Exchange do
    include MessagingHelpers

    subject { Exchange.new(script: script) }

    describe '#determine_response' do
      context 'with a single script' do
        let(:script) { load_script(:two_messages) }

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

    describe '#process_commands' do
      let(:script) { load_script(:with_command) }
      let(:processor) { TestCommandProcessor.new }

      it 'sends commands to command processor' do
        subject.user_input to: 'with_command', input: { 'text' => 'I do not know' }
        subject.process_commands processor

        expect(processor.received_commands).to eq([['have_existential_crisis', {'text' => 'I do not know'}]])
      end
    end
  end
end
