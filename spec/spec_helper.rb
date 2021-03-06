require './app.rb'

require 'capybara/rspec'
require 'sinatra'
require 'rack/test'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

Capybara.app = Sinatra::Application

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/test.db")
  DataMapper.finalize
  User.auto_migrate!
  Task.auto_migrate!
end
