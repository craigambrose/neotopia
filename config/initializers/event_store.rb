require 'event_sourcing/client'

Rails.application.config.event_store = EventSourcing::Client.new
