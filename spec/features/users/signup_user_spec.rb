require "rails_helper"

RSpec.feature "Sign-up User" do
  scenario " valid credential" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: "me@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content("You have signed up successfully.")

  end
  scenario "with invalid credential" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    # expect(page.current_path).to eq(new_user_registration_path)
  end
end