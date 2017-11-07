require 'event_sourcing/client'

module EventsSetup
  def self.setup_event_subscriptions(client)
    client.subscribe(Users::Events::SignedUp::Handler.new, [Users::Events::SignedUp])
    client
  end
end
