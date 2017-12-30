require 'messaging/validation_failure'

module Users
  module Commands
    class SignUp
      include ActiveModel::Validations
      include Passwords
      include UserEvents

      attr_accessor :email, :password

      validates :email, presence: true, email_format: true
      validates :password, presence: true
      validate  :email_is_unique

      def call(input, context)
        self.email = input['email']
        self.password = input['password']

        if valid?
          user_uuid = context.user_uuid
          user_name = context.user_name
          publish_user_event user_uuid, Events::SignedUp.new(data: event_data(user_uuid, user_name))
          nil
        else
          build_error
        end
      end

      private

      def build_error
        if errors[:email].include?('email_exists')
          Messaging::ValidationFailure.new('email_exists', errors)
        else
          Messaging::ValidationFailure.new(errors)
        end
      end

      def event_data(user_uuid, user_name)
        {
          uuid: user_uuid,
          name: user_name,
          email: email,
          encrypted_password: encrypt_password(password)
        }
      end

      def email_is_unique
        if email.present? && User.where(email: email).exists?
          errors.add(:email, 'email_exists')
        end
      end
    end
  end
end
