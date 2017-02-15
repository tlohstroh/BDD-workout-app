require "rails_helper"

RSpec.feature "Search For Users" do
  before do
    # need to have users before I can find them..
    @john = User.create( first_name: "John", last_name: "Doe", email: "john@example.com", password: "password" )
    @sarah = User.create( first_name: "Sarah", last_name: "Doe", email: "sarah@example.com", password: "password" )
  end

  scenario "with existing name returns all users with that name" do
    visit '/'
    fill_in "search_name", with: "Doe"
    click_button "Search"

    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@sarah.full_name)
    expect(current_path).to eq("/dashboards/search")
  end
end
