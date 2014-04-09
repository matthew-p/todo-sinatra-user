require "spec_helper"

describe "the app", type: :feature do

  it "goes to the home page, and displayes log in & sign up only" do

    visit '/'
    expect(page).to have_content "Log In"
    expect(page).to have_no_content "New Task"
  end

  it "clicks login and goes to login page" do

    visit '/'
    click_link 'Log In'
    expect(page).to have_content "Log In"
    expect(page).to have_no_content "You are already logged in"
  end

  it "fails to log in to a non-existent account" do

    visit '/login'
    fill_in "username", with: "no-account"
    click_button "submit"
    expect(page).to have_content "The username you entered does not appear in the database"
    expect(page).to have_no_content "successfully logged in"
  end

  it "creates a new account" do

    visit '/'
    click_link "Sign Up"
    fill_in "username", with: "capybara-account"
    click_button "submit"
    expect(page).to have_content "Successfully Signed Up"
  end

  it "logs in" do

    visit '/login'
    fill_in "username", with: "capybara-account"
    click_button "submit"
    expect(page).to have_content "capybara-account successfully logged in"
    expect(page).to have_content "Signed in as: capybara-account"
  end

  it "views empty list of tasks" do
    visit '/login'
    fill_in "username", with: "capybara-account"
    click_button "submit"
    visit '/'
    expect(page).to have_content "Tasks"
    expect(page).to have_no_content "Log In"
    click_link "tasks"
    expect(page).to have_content "No Tasks"
  end

  it "creates a new task" do
    visit '/login'
    fill_in "username", with: "capybara-account"
    click_button "submit"

    visit "/tasks"
    click_link "new"
    expect(page).to have_content "What do you need to do"
    fill_in "content", with: "task a"
    click_button "Submit"
    expect(page).to have_content "task a"
  end

  it "views & modifies the task" do
    visit '/login'
    fill_in "username", with: "capybara-account"
    click_button "submit"

    visit '/tasks'
    click_on "task a"
    expect(page).to have_content "task a"
    expect(page).to have_content "This task belongs to: capybara-account"
    visit '/tasks'
    click_link "Edit"
    expect(page).to have_content "Edit Task"
    fill_in "content", with: "1"
    click_button "task_submit"
    expect(page).to have_content "1"
  end

  it "marks the task as done / not done" do
    visit '/login'
    fill_in "username", with: "capybara-account"
    click_button "submit"

    visit '/tasks'
    click_on "Not Done"
    expect(page).to have_no_content "Not Done"
    click_on "Done"
    expect(page).to have_content "Not Done"
  end

  it "destroys the task" do
    visit '/login'
    fill_in "username", with: "capybara-account"
    click_button "submit"

    visit '/tasks'
    click_link "edit"
    expect(page).to have_content "Edit Task"
    click_link "delete"
    expect(page).to have_content "No Tasks"
  end

  it "logs out" do
    visit '/login'
    fill_in "username", with: "capybara-account"
    click_button "submit"

    visit '/tasks'
    click_on "Log Out"
    expect(page).to have_content "Logged Out"
  end

end
