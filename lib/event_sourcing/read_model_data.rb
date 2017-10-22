module EventSourcing
  class ReadModelData
    def initialize(store = Rails.configuration.event_store)
      @store = store
    end

    def generate_all
      each_event do |event|
        renotify_event event
      end
    end

    private

    attr_reader :store

    def each_event(&block)
      page = RubyEventStore::Client::Page.new(repository, :head, page_size)

      until (results = repository.read_all_streams_forward(page.start, page.count)).empty?
        results.each(&block)
        page.instance_variable_set :@start, results.last.event_id
      end
    end

    def renotify_event(event)
      broker.notify_subscribers(event)
    end

    def page_size
      store.send :page_size
    end

    def repository
      store.send :repository
    end

    def broker
      store.send :event_broker
    end
  end
end
