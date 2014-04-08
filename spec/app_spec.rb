require "spec_helper"

# note: some of these tests are written for rspec instead of capybara simply because I wrote them before integrating capybara.

describe "This Sinatra App" do

  it "should respond to GET '/' & display 'Todo App'" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('ToDo App')
  end

  it "should respond to GET /signup and display Sign Up" do
    get '/signup'
    expect(last_response).to be_ok
    expect(last_response.body).to include("Sign Up")
  end

  it "should respond to GET /signup/success" do
    get '/signup/success'
    expect(last_response).to be_ok
    expect(last_response.body).to include("Successfully Signed Up")
  end

  it "should respond to GET '/login' & display 'Login'" do
    get '/login'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Log In')
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

  it "should respond to post /task/create" do
    post '/task/create'
    expect(last_response).to be_redirect
    expect(last_response.location).to include("/tasks")

  end


end

describe "the signup process", type: :feature do

  it "goes to the signup page" do
    visit '/'
    click_link 'Sign Up'
    expect(page).to have_content 'signup page'
  end

  it "goes to the log in page" do
    visit '/'
    click_link "Log In"
    expect(page).to have_content 'login page'
  end

  it "goes to the logout page" do
    visit '/'
    click_link 'Log Out'
    expect(page).to have_content 'Logged Out'
  end

  it "logs in" do
    visit '/login'
    fill_in "username", with: 'test'
    click_button 'submit'
    expect(page).to have_content 'test successfully logged in!'
    expect(page).to have_content 'is: test'
  end

end
