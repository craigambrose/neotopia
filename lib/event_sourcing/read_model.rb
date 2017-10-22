require_relative 'read_model_schema'
require_relative 'read_model_data'

module EventSourcing
  class ReadModel
    def initialize(store = Rails.configuration.event_store)
      @schema = ReadModelSchema.new
      @data = ReadModelData.new(store)
    end

    def rebuild
      @schema.reacreate_schema
      @data.generate_all
    end
  end
end
