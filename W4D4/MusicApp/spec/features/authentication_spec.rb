require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'username', :with => "testing_username"
      fill_in 'password', :with => "biscuits"
      click_on "Create User"
    end

    scenario "redirects to team index page after signup" do
      expect(page). to have_content "Team Index Page"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "testing_username"
    end
  end
end 
