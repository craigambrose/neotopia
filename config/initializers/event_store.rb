require 'event_sourcing/client'

Rails.application.config.event_store = EventSourcing::Client.new
EventsSetup.setup_event_subscriptions Rails.configuration.event_store
