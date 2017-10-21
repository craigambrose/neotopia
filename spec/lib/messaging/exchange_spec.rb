require 'spec_helper'
require_relative 'messaging_helpers'

require 'messaging/exchange'

module Messaging
  describe Exchange do
    include MessagingHelpers

    describe '#something' do
      let(:script) { load_script(:two_messages) }

      it 'does something' do
        exchange = Exchange.new(script: script)
        exchange.user_input to: 'new_user?', input: { 'text' => 'yes' }
        message = exchange.determine_response

        expect(message.id).to eq('whats_your_name?')
      end
    end
  end
end
