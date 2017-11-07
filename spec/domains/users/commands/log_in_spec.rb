require 'rails_helper'

module Users
  module Commands
    describe LogIn do
      include EventSourcingHelpers

      let(:context) { TestContext.new }

      class TestContext
        attr_accessor :user_uuid, :user_name
      end

      describe '#call' do
        context 'with valid credentials' do
          it 'logs no event, but sets user name and uuid on the context' do
            michael = create(:user, :michael)
            input = {'email' => michael.email, 'password' => 'grokthis'}

            result = subject.call(input, context)

            expect(result).to be_nil
            expect(latest_event).to be_nil
            expect(context.user_uuid).to eq(michael.uuid)
            expect(context.user_name).to eq(michael.name)
          end
        end

        context 'with invalid credentials' do
          it 'doesnt change the context and returns validation failure' do
            michael = create(:user, :michael)
            input = {'email' => michael.email, 'password' => 'someotherpass'}

            result = subject.call(input, context)

            expect(result).to be_a(Messaging::ValidationFailure)
            expect(context.user_uuid).to be_nil
            expect(context.user_name).to be_nil
            expect(latest_event).to be_nil
          end
        end
      end
    end
  end
end
