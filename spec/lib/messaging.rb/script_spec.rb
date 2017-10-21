require 'spec_helper'

require 'messaging/script'

module Messaging
  describe Script do
    def fixture_file(name)
      File.open(File.join(File.dirname(__FILE__), 'fixtures', "#{name}.json"))
    end

    describe '#find_message' do
      context 'for a valid script' do
        subject { Script.from_file(fixture_file(:two_messages)) }

        it 'can find a message' do
          message = subject.find_message 'whats_your_name?'

          expect(message).to_not be_nil
          expect(message.prompt).to eq('How exciting, and what should I call you?')
        end
      end
    end
  end
end
