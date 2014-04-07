require "spec_helper"

describe "This Sinatra App" do

  it "should respond to GET '/' & display 'Todo App'" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('ToDo App')
  end

  it "should respond to GET '/login' & display 'Login'" do
    get '/login'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Login')
  end

  it "should respond to get /logout and display 'logged out'" do
    get '/logout'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Logged Out')
  end

  it "should respond to get /tasks & display Tasks" do
    get '/tasks'
    expect(last_response).to be_ok
    expect(last_response.body).to include("Tasks")
  end

  it "should respond to get /task/new & display 'what do you need to do?'" do
    get '/task/new'
    expect(last_response).to be_ok
    expect(last_response.body).to include("What do you need to do?")
  end

  it "should respond to pst /task/create" do
    post '/task/create'
    expect(last_response).to be_ok
  end


end
