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

            subject.call(input, context)

            expect(latest_event).to be_a(::Users::Events::SignedUp)
            user = User.find_by_uuid(user_uuid)
            expect(user).not_to be_nil
            expect(user.name).to eq('Jubal')
          end
        end
      end
    end
  end
end
