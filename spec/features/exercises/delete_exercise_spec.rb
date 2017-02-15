require "rails_helper"

RSpec.feature "Edit Exercise" do
  before do
    # create a user
    @tjitske = User.create(first_name: "John", last_name: "Doe", email: "tjitske@example.com", password: "password" )
    # create 2 exercises
    @tjitske_exercise = @tjitske.exercises.create(duration_in_min: 46,
                                            workout: "I'm a pushup machine",
                                            workout_date: Date.today)
                                            # login
    login_as(@tjitske)
  end

  scenario "shows user's workouts last 7 days" do
    visit "/"

    click_link "My Lounge"
    # NOTE !!!
    path = "/users/#{@tjitske.id}/exercises/#{@tjitske_exercise.id}"
    link = "//a[contains(@href,\'#{path}\') and .//text()='Delete']"
    find(:xpath, link).click


    expect(page).to have_content("Exercise has been deleted")


  end


end
