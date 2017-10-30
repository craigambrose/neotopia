require 'messaging/validation_failure'

module Users
  module Commands
    class SignUp
      include ActiveModel::Validations
      include Passwords
      include UserEvents

      class Event < RailsEventStore::Event; end

      attr_accessor :email, :password

      validates :email, presence: true, email_format: true
      validates :password, presence: true, length: {minimum: 8}

      def call(input, context)
        self.email = input['email']
        self.password = input['password']

        if valid?
          user_uuid = context.user_uuid
          publish_user_event user_uuid, Event.new(data: event_data)
        else
          Messaging::ValidationFailure.new(errors)
        end
      end

      private

      def event_data
        {
          user_uuid: user_uuid,
          email: email,
          encrypted_password: encrypt_password(password)
        }
      end
    end
  end
end
