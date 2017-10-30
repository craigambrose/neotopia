module Users
  module Commands
    class SignUp
      class Event < RailsEventStore::Event; end

      def call(input, context)
        user_uuid = context.user_uuid
        publish_user_event user_uuid, Event.new(
          data: {
            user_uuid: user_uuid,
            email: input['email'],
            encrypted_password: encrypt_password(input['password'])
          }
        )
      end

      private

      def publish_user_event(user_uuid, event)
        raise ArgumentError, 'user uuid needed for event publish' if user_uuid.blank?
        publish_event event, stream_name: "user-#{user_uuid}"
      end

      def publish_event(*params)
        event_store.publish_event *params
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
