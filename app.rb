require 'sinatra'
require 'data_mapper'
require './lib/app_logic'
require './lib/helpers'

enable :sessions

get '/' do
  @user = User.authenticate(session["user"])
  erb :'index.html', layout: :layout_hero
end

get '/signup' do
  erb :'signup.html'
end

post '/signup/create' do
  user = User.new(username: params[:username], created_at: Time.now)
  database_save_check(user, '/signup/success', '/')
=begin
  if user.save
    status 201
    redirect '/signup/success'
  else
    status 412
    redirect '/'
  end
=end
end

get '/signup/success' do
  erb :'signup_success.html'
end


get '/login' do
  @authenticate = User.authenticate(session["user"])
  if session["user"] == nil
    erb :'login.html'
  elsif @authenticate == nil
    redirect '/login/failure/improper'
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

get '/login/failure/improper' do
  erb :'improper_user.html'
end

post '/login/attempt' do
  result = User.authenticate(params[:username].downcase)
  if result != nil
    session["user"] = result
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
#  if User.authenticate(session["user"]) != nil
  if logged_in
    @tasks = session_user.tasks
    erb :'tasks.html', layout: :layout_tasks
  else
    redirect '/login'
  end
end

get '/task/new' do
#  if User.authenticate(session["user"]) != nil
  if logged_in
    erb :'task_new.html'
  else
    redirect '/login'
  end
end

post '/task/create' do
  @user = session_user
  task = @user.tasks.new(content: params[:content], created_at: Time.now)
# check to save task to database
  database_save_check(task, '/tasks', '/tasks')

end

get '/task/:id' do
#  if User.authenticate(session["user"]) != nil
  if logged_in
    @task = User.first(username:session["user"]).tasks.get(params[:id])

    erb :'task.html'
  else
    redirect '/login'
  end
end

get '/task/:id/edit' do
#  if User.authenticate(session["user"]) != nil
  if logged_in
    @task = User.first(username:session["user"]).tasks.get(params[:id])
    erb :'task_edit.html'
  else
    redirect '/login'
  end
end

put '/task/:id' do
#  if User.authenticate(session["user"]) != nil
  if logged_in
    @task = User.first(username:session["user"]).tasks.get(params[:id])
    @task.content = params[:content]
    database_save_check(@task, '/tasks', '/tasks')
  else
    redirect '/login'
  end
end

get '/task/:id/delete' do
#  if User.authenticate(session["user"]) != nil
  if logged_in
    @task = User.first(username:session["user"]).tasks.get(params[:id])
    @task.destroy
    redirect '/tasks'
  else
    redirect '/login'
  end
end

get '/task/:id/done' do
#  if User.authenticate(session["user"]) != nil
  if logged_in
    @item = session_user.tasks.get(params[:id])
    completed = @item.completed
    if completed != true
      @item.completed = true
      @item.completed_at = Time.now
      database_save_check(@item, '/tasks', '/tasks')
    else
      @item.completed = false
      @item.completed_at = nil
      database_save_check(@item, '/tasks', '/tasks')
    end
  else
    redirect '/login'
  end
end

get '/admin' do
  erb :'admin.html'
end







