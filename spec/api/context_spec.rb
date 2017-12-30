require 'rails_helper'

describe Context do
  let(:context) { Context.new }

  describe 'signed_up?' do
    it 'is false with no user_uuid' do
      expect(Context.new.signed_up?).to be false
    end

    it 'is false with user uuid not found in the database' do
      context.user_uuid = 'foobar'
      expect(Context.new.signed_up?).to be false
    end

    it 'is true if there is a user' do
      user = create(:user, :michael)
      context.user_uuid = user.uuid
      expect(context.signed_up?).to be true
    end
  end
end
