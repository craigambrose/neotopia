ENV['RAILS_ENV'] = 'test'

require 'cucumber/rails'
require 'selenium/webdriver'

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu] }
  )

  Capybara::Selenium::Driver.new app, browser: :chrome, desired_capabilities: capabilities
end

Capybara.javascript_driver = :headless_chrome

Cucumber::Rails::Database.javascript_strategy = :truncation

World(FactoryGirl::Syntax::Methods)
require Rails.root.join('spec', 'factories')
