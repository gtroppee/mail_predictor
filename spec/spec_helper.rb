RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/**/*.rb")].each(&method(:require))

# FactoryGirl setup
FactoryGirl.definition_file_paths = [
  File.join(Padrino.root, 'factories'),
  File.join(Padrino.root, 'test', 'factories'),
  File.join(Padrino.root, 'spec', 'factories')
]
FactoryGirl.find_definitions

# Rspec setup
RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include FactoryGirl::Syntax::Methods

  conf.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  conf.before(:each) do
    DatabaseCleaner.start
  end

  conf.after(:each) do
    DatabaseCleaner.clean
  end
end

def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end

# Capybara Setup
require 'capybara/rspec'
require 'capybara/poltergeist'
include Capybara::DSL
Capybara.app = @app
Capybara.save_and_open_page_path = "#{Padrino.root}/tmp/capybara_snapshots"
Capybara.configure do |conf|
  conf.javascript_driver = :poltergeist
  conf.default_driver = :poltergeist
  conf.app_host = 'http://localhost:3000'
end

# Custom Setup
require 'utilities'

