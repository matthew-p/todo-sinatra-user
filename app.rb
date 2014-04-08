require 'sinatra'
require 'data_mapper'
require './lib/app_logic'

enable :sessions

get '/' do
  erb :'index.html'
end

get '/signup' do
  erb :'signup.html'
end

post '/signup/create' do
  user = User.new(username: params[:username], created_at: Time.now)
  if user.save
    status 201
    redirect '/signup/success'
  else
    status 412
    redirect '/'
  end
end

get '/signup/success' do
  erb :'signup_success.html'
end


get '/login' do
  if session["user"] == nil
    erb :'login.html'
  else
    redirect '/login/failure/current'

  end
end

get '/login/failure' do
  erb :'login_failed.html'
end

get '/login/failure/current' do
  erb :'already_logged_in.html'
end

get '/login/attempt' do
  result = User.authenticate(params[:username])
  if result != nil
    session["user"] = User.authenticate(params[:username])
    redirect '/login/success'
  else
    redirect '/login/failure'
  end
end

get '/login/success' do
  erb :'login_success.html'
end

get '/logout' do
  session["user"] = nil
  erb :'logout.html'
end

get '/tasks' do
  @tasks = User.first(username: session["user"]).tasks
  erb :'tasks.html'
end

get '/task/new' do
  erb :'task_new.html'
end

post '/task/create' do
  @user = User.first(username: session["user"])
  task = @user.tasks.new(content: params[:content], created_at: Time.now)
  if task.save
    status 201
    redirect '/task/' + task.id.to_s
  else
    status 412
    redirect '/tasks'
  end
end

get '/task/:id' do
  @task = Task.get(params[:id])
  erb :'task.html'
end





