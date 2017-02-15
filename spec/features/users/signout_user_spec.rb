require "rails_helper"

RSpec.feature "Signout User" do
  before do
    @tjitske = User.create!(first_name: "John", last_name: "Doe", email: "tjitske@example.com", password: "password")
    visit '/'
    click_link "Sign in"
    fill_in "Email", with: @tjitske.email
    fill_in "Password",  with: "password"
    click_button "Log in"
  end

  scenario "" do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content("Signed out successfully.")
    # expect(page).not_to have_content("Sign out")
  end

end
