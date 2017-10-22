module EventSourcing
  class ReadModelSchema
    def initialize
      @connection = ActiveRecord::Base.connection
      @schema_name = 'read_model'
      @filename = Rails.root.join('db/read_model.rb')
    end

    def create_schema
      execute "CREATE SCHEMA #{schema_name}"
    end

    def load_schema
      create_schema
      with_read_model_schema do
        ActiveRecord::Tasks::DatabaseTasks.send :load, filename
      end
    end

    def drop_schema
      execute "DROP SCHEMA #{schema_name} CASCADE"
    rescue ActiveRecord::StatementInvalid
      puts "Schema #{schema_name} doesn't exist, skipping."
    end

    def reacreate_schema
      drop_schema
      load_schema
    end

    private

    attr_reader :schema_name, :filename

    def with_read_model_schema(&block)
      with_search_path schema_name, &block
    end

    def with_search_path(new_path)
      old_path = conn.schema_search_path
      conn.schema_search_path = new_path
      yield
    rescue RuntimeError => exception
      raise exception
    ensure
      conn.schema_search_path = old_path
    end

    def execute(sql)
      puts sql
      conn.execute sql
    end

    def conn
      @connection
    end
  end
end
