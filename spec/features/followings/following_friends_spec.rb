require "rails_helper"

RSpec.feature "Edit Exercise" do
  before do

    @tjitske = User.create( first_name: "Tjitske", last_name: "Lohstroh", email: "tjitske@example.com", password: "password" )
    @john = User.create( first_name: "John", last_name: "Doe", email: "john@example.com", password: "password" )
    login_as(@john)
  end

  scenario "if signed in" do
    visit "/"

    expect(page).to have_content(@tjitske.full_name)
    expect(page).to have_content(@tjitske.full_name)

    # if John is signed in he shouldn't see a follow button behind his name
    href = "/friendships?friend_id=#{@john.id}"
    expect(page).not_to have_content("Follow", :href => href)

    # he should find a follow button behind tjitske's name and click it..
    # NOTE !!
    link = "a[href= '/friendships?friend_id=#{@tjitske.id}']"
    find(link).click

    # after that tjitske's follow button should have disappeared
    href = "/friendships?friend_id=#{@tjitske.id}"
    expect(page).not_to have_content("Follow", :href => href)
  end
end
