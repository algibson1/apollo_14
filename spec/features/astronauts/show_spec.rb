require "rails_helper"

RSpec.describe "Astronauts Show" do
  it "shows astronaut name and missions list" do 
    #     Extension 1
    neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")

    capricorn = Mission.create!(title: "Capricorn 4", time_in_space: 18)
    gemini = Mission.create!(title: "Gemini 7", time_in_space: 100)
    apollo = Mission.create!(title: "Apollo 13", time_in_space: 24)

    neil.missions << [capricorn, gemini, apollo]
    # As a visitor, 
    # When I visit an astronaut's show page (/astronauts/:id)
    visit "/astronauts/#{neil.id}"
    # I see the name of that astronaut 
    expect(page).to have_content("Neil Armstrong")
    # And a list of the missions this astronaut has been on.
    expect(page).to have_content("Capricorn 4")
    expect(page).to have_content("Gemini 7")
    expect(page).to have_content("Apollo 13")
    # (e.g. Neil Armstrong
    # Missions: Apollo 13, Capricorn 4)
  end

  it "adds a mission to an astronaut" do
    #     Extension 2
    neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
    capricorn = Mission.create!(title: "Capricorn 4", time_in_space: 18)
    gemini = Mission.create!(title: "Gemini 7", time_in_space: 100)
    apollo = Mission.create!(title: "Apollo 13", time_in_space: 24)

    neil.missions << [capricorn, gemini]
    # As a visitor, 
    # When I visit an astronaut's show page (/astronauts/:id)
    visit "/astronauts/#{neil.id}"
    # I see a form to add a mission to this astronaut
    expect(page).to_not have_content("Apollo 13")
    expect(page).to have_field(:mission_id)
    # When I fill out the form with an ID of an existing mission
    fill_in(:mission_id, with: apollo.id)
    click_button("Lift Off")
    # I am redirected back to the Astronaut's show page
    expect(page).to have_current_path("/astronauts/#{neil.id}")
    # Where I see the new mission's name listed. 
    expect(page).to have_content("Apollo 13")
  end

end