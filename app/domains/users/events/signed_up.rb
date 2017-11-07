module Users
  module Events
    class SignedUp < RailsEventStore::Event
      class Handler
        def call(event)
          User.create!(event.data)
        end
      end
    end
  end
end
