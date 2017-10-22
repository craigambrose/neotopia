module EventSourcing
  class Client < RailsEventStore::Client
    def initialize(*params)
      super(*params)
      @replay_mode = false
    end

    attr_reader :replay_mode

    def replay_mode?
      replay_mode
    end

    def in_replay_mode
      old_mode = replay_mode
      @replay_mode = true
      yield
    ensure
      @replay_mode = old_mode
    end
  end
end
