require 'sinatra'
require './lib/app_logic'

get '/' do
  erb :'index.html'
end

get '/login' do
  erb :'index.html'
end

get '/logout' do
  erb :'logout.html'
end

get '/tasks' do
  erb :'tasks.html'
end

get '/task/new' do
  erb :'task_new.html'
end

post '/task/create' do

  redirect '/tasks'
end



