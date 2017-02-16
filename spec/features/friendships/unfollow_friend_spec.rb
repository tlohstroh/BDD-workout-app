require 'rails_helper'

RSpec.feature "List Workouts" do
  before do
    @tjitske = User.create( first_name: "John", last_name: "Doe", email: "tjitske@example.com", password: "password" )
    @femke = User.create( first_name: "Femke", last_name: "van Nuijs", email: "femke@example.com", password: "password" )


    # create 2 exercises
    @exercise1 = @tjitske.exercises.create(duration_in_min: 20,
                                            workout: "I'm a pushup machine",
                                            workout_date: Date.today)

    @exercise2 = @femke.exercises.create(duration_in_min: 50,
                                           workout: "Running",
                                           workout_date: 2.days.ago)
    login_as(@tjitske)

    @following = Friendship.create(user: @tjitske, friend: @femke)

  end

  scenario "" do
    visit "/"
    click_link "My Lounge"
    # click on the unfollow link with the right paht
    link = "a[href='/friendships/#{@following.id}'][data-method='delete']"
    find(link).click

    expect(page).to have_content(@femke.full_name + " unfollowed")

  end
end
