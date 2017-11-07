require 'event_sourcing/read_model'

module EventSourcingHelpers
  def rebuild_read_model
    EventSourcing::ReadModel.new(suppress_stdout: true).rebuild
  end

  def latest_event
    event_store.read_all_streams_backward(start: :head, count: 1).first
  end

  def event_store
    Rails.configuration.event_store
  end
end
