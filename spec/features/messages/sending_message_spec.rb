require "rails_helper"

RSpec.feature "Send Message" do
  before do
    # create two users
    @tjitske = User.create!( first_name: "John", last_name: "Doe", email: "tjitske@example.com", password: "password" )
    @femke = User.create!( first_name: "Femke", last_name: "van Nuijs", email: "femke@example.com", password: "password" )
    @eric = User.create!( first_name: "Eric", last_name: "Savelberg", email: "eric@example.com", password: "password" )

    @room_name = @tjitske.first_name + "-" + @tjitske.last_name
    @room = Room.create!(name: @room_name, user_id: @tjitske.id)
    # login one user
    login_as @tjitske

    # create friendships
    Friendship.create(user: @femke, friend: @tjitske)
    Friendship.create(user: @eric, friend: @tjitske)
  end


  scenario "say hello to other user" do
    # visit Lounge
    visit "/"
    click_link "My Lounge"
    expect(page).to have_content(@room_name)

    # type Message
    fill_in "message-field", with: "Hello"
    # hit Send
    click_button "Post"

    # expect page to have message
    expect(page).to have_content("Hello")

    within("#followers") do
      expect(page).to have_link(@femke.full_name)
      expect(page).to have_link(@eric.full_name)
    end
  end
end
