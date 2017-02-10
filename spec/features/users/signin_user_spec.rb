require "rails_helper"

RSpec.feature "Sign in users" do

  before do
    @tjitske = User.create(email: "tjitske@example.com", password: "password")
  end

  scenario "With valid credentials" do
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: "tjitske@example.com"
    fill_in "Password", with: "password"
    click_button "Log in"

    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Signed in as tjitske@example.com")
    # expect(page).not_to have_link("Sign in")
    # expect(page).not_to have_link("Sign up")

  end

  # scenario "with invalid credentials" do
  #
  #   visit "/"
  #   click_link "Sign in"
  #   fill_in "Email", with: ""
  #   fill_in "Password", with: ""
  #   click_button "Log in"
  #
  #   expect(page).to have_content("wrong password or email")
  #   expect(page).not_to have_content("tjitske@example.com")
  #   expect(page).to have_link("Sign in")
  #   expect(page).to have_link("Sign up")
  #
  # end

end
