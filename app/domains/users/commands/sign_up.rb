require 'messaging/validation_failure'

module Users
  module Commands
    class SignUp
      include ActiveModel::Validations
      include Passwords
      include UserEvents

      attr_accessor :email, :password

      validates :email, presence: true, email_format: true
      validates :password, presence: true, length: {minimum: 8}

      def call(input, context)
        self.email = input['email']
        self.password = input['password']

        if valid?
          user_uuid = context.user_uuid
          user_name = context.user_name
          publish_user_event user_uuid, Events::SignedUp.new(data: event_data(user_uuid, user_name))
          nil
        else
          Messaging::ValidationFailure.new(errors)
        end
      end

      private

      def event_data(user_uuid, user_name)
        {
          uuid: user_uuid,
          name: user_name,
          email: email,
          encrypted_password: encrypt_password(password)
        }
      end
    end
  end
end
