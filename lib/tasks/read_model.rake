require 'event_sourcing/read_model_schema'
require 'event_sourcing/read_model'

namespace :read_model do
  desc 'Load empty read model schema'
  task load_schema: :environment do
    EventSourcing::ReadModelSchema.new.load_schema
  end

  desc 'Drop read model schema'
  task drop_schema: :environment do
    EventSourcing::ReadModelSchema.new.drop_schema
  end

  desc 'Fully re-build the read model'
  task rebuild: :environment do
    EventSourcing::ReadModel.new.rebuild
  end
end

Rake::Task['db:setup'].clear
task 'db:setup' => ['db:schema:load', 'read_model:load_schema']

task 'db:test:load' => ['read_model:drop_schema', 'read_model:load_schema']
