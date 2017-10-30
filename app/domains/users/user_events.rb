module Users
  module UserEvents
    private

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
  end
end
