require 'rails_helper'

module Users
  module Commands
    describe SignUp do
      include EventSourcingHelpers

      let(:context) { double(Context) }
      let(:user_uuid) { 'abc123' }

      describe '#call' do
        context 'with valid data' do
          it 'fires event and creates a user in the read model' do
            input = {'email' => 'jubal@user.com', 'password' => 'mypassword'}
            allow(context).to receive(:user_uuid).and_return(user_uuid)
            allow(context).to receive(:user_name).and_return('Jubal')

            result = subject.call(input, context)

            expect(result).to be_nil
            expect(latest_event).to be_a(::Users::Events::SignedUp)
            user = User.find_by_uuid(user_uuid)
            expect(user).not_to be_nil
            expect(user.name).to eq('Jubal')
          end
        end

        context 'with invalid data' do
          it 'returns validation failure and doesnt fire event' do
            input = {'email' => 'jubal@user.com', 'password' => ''}

            result = subject.call(input, context)

            expect(result).to be_a(Messaging::ValidationFailure)
            expect(latest_event).to be_nil
          end

          it 'sets the error_name to email_exists if duplicate found' do
            michael = create(:user, :michael)

            input = {'email' => michael.email, 'password' => 'validpass'}

            result = subject.call(input, context)

            expect(result).to be_a(Messaging::ValidationFailure)
            expect(result.error_name).to eq('email_exists')
            expect(latest_event).to be_nil
          end
        end
      end
    end
  end
end
