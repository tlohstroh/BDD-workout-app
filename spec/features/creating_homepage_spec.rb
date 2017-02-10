require "rails_helper"

RSpec.feature "Creaing Homepage" do

  scenario "" do
    visit "/"

    # We should see a link called "Home"
    expect(page).to have_link("Home")
    # We sould see a link called "Athletes Den"
    expect(page).to have_link("Athletes Den")
    # We should see content "Workout Lounge"
    expect(page).to have_content("Workout Lounge")
    # We should see content "Show off your workout"
    expect(page).to have_content("Show off your workout")

    # call the controller DashboardsController

  end




end
