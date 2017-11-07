# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

if %w[development test].include? Rails.env
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  task :rails_best_practices do
    sh 'rails_best_practices .'
  end

  task :test_client do
    sh 'yarn run elm-test --fuzz=1'
  end

  task ci: [:rubocop, :rails_best_practices, :spec, :test_client, :cucumber]
  task default: :ci
end
