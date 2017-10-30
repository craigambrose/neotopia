module Users
  module Commands
    class SignUp
      include ActiveModel::Validations

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
          raise "failed validation with #{errors.inspect}"
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

      def publish_user_event(user_uuid, event)
        raise ArgumentError, 'user uuid needed for event publish' if user_uuid.blank?
        publish_event event, stream_name: "user-#{user_uuid}"
      end

      def publish_event(*params)
        event_store.publish_event(*params)
      end

      def event_store
        Rails.configuration.event_store
      end

      def encrypt_password(password)
        raise ArgumentError, "password can't be blank" if password.blank?
        BCrypt::Password.create(password, cost: 10)
      end
    end
  end
end
