require 'rails_helper'

RSpec.feature "List Workouts" do
  before do
    # create a user
    @tjitske = User.create( first_name: "John", last_name: "Doe", email: "tjitske@example.com", password: "password" )
    @femke = User.create( first_name: "Femke", last_name: "van Nuijs", email: "femke@example.com", password: "password" )
    # login
    login_as(@tjitske)
    # create 2 exercises
    @exercise1 = @tjitske.exercises.create(duration_in_min: 20,
                                            workout: "I'm a pushup machine",
                                            workout_date: Date.today)

    @exercise2 = @tjitske.exercises.create(duration_in_min: 50,
                                           workout: "Running",
                                           workout_date: 2.days.ago)

    @exercise3 = @tjitske.exercises.create(duration_in_min: 40,
                                            workout: "Running again",
                                            workout_date: 8.days.ago)

    @folowing = Friendship.create(user: @tjitske, friend: @femke)

  end

  scenario "shows user's workouts last 7 days" do
    visit "/"

    click_link "My Lounge"

    expect(page).to have_content(@exercise1.duration_in_min)
    expect(page).to have_content(@exercise1.workout)
    expect(page).to have_content(@exercise1.workout_date)

    expect(page).to have_content(@exercise2.duration_in_min)
    expect(page).to have_content(@exercise2.workout)
    expect(page).to have_content(@exercise2.workout_date)

    expect(page).not_to have_content(@exercise3.duration_in_min)
    expect(page).not_to have_content(@exercise3.workout)
    expect(page).not_to have_content(@exercise3.workout_date)

  end

  scenario "user has no exercises" do
    # let op! eerst bovenstaande exercises deleten
    @tjitske.exercises.delete_all

    visit "/"
    click_link "My Lounge"
    expect(page).to have_content("No Workouts Yet")


  end

  scenario "show a list of user's friends" do
    visit "/"
    click_link "My Lounge"

    expect(page).to have_content("My Friends")
    expect(page).to have_link(@femke.full_name)
    expect(page).to have_link("Unfollow")
  end
end
