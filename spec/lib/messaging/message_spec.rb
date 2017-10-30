require 'spec_helper'
require_relative 'messaging_helpers'

require 'messaging/message'
require 'messaging/interpolator'

module Messaging
  describe Message do
    include MessagingHelpers

    describe '#transition_target' do
      context 'for a valid script' do
        it 'returns the id matching text input' do
          message = load_message(:two_messages, 'new_user?')
          input = {'text' => 'yes'}

          target = message.transition_for(input)

          expect(target.target_message_id).to eq('whats_your_name?')
        end

        it 'returns id for default by default' do
          message = load_message(:default_transition, 'first')
          input = {'text' => 'some bollocks'}

          target = message.transition_for(input)

          expect(target.target_message_id).to eq('second')
        end
      end
    end

    describe '#as_json' do
      it 'returns correct data' do
        message = load_message(:two_messages, 'new_user?')
        expect(message.as_json).to eq(
          id: 'new_user?',
          prompt: 'Welcome, are you new here?',
          responder: {
            'responder_type' => 'select_option',
            'options' => ['yes', 'no']
          }
        )
      end

      context 'with an interpolator' do
        let(:interpolator) { instance_double('Messaging::Interpolator') }

        it 'performs string interpolating using context' do
          allow(interpolator).to receive(:interpolate).with('Welcome back {{current_user.name}}').and_return('Welcome back Bob')
          message = load_message(:two_messages, 'new_user?')
          message.prompt = 'Welcome back {{current_user.name}}'

          expect(message.as_json(interpolator)[:prompt]).to eq('Welcome back Bob')
        end
      end
    end
  end
end
