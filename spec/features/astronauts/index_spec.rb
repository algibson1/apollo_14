require "rails_helper"

RSpec.describe "Astronaut Index Page" do
  it "has all astronauts and their name, age, and job" do
    # User Story 1 of 4
    neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
    buzz = Astronaut.create!(name: "Buzz Aldrin", age: 42, job: "Supreme Commander")
    lightyear = Astronaut.create!(name: "Buzz Lightyear", age: 789, job: "Master Chief")
    # As a visitor,
    # When I visit the Astronauts index page ('/astronauts')
    visit "/astronauts"
    # I see a list of astronauts with the following info:
    # - Name
    # - Age
    # - Job
    expect(page).to have_content("Name: Neil Armstrong, Age: 37, Job: Commander")
    expect(page).to have_content("Name: Buzz Aldrin, Age: 42, Job: Supreme Commander")
    expect(page).to have_content("Name: Buzz Lightyear, Age: 789, Job: Master Chief")
    # (e.g. "Name: Neil Armstrong, Age: 37, Job: Commander")
  end

  it "has the average age of all astronauts" do
    #  As a visitor,
    neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
    buzz = Astronaut.create!(name: "Buzz Aldrin", age: 42, job: "Supreme Commander")
    lightyear = Astronaut.create!(name: "Buzz Lightyear", age: 789, job: "Master Chief")
    # When I visit the Astronauts index page ('/astronauts')
    visit "/astronauts"
    # I see the average age of all astronauts.
    expect(page).to have_content("Average Age: 289.33")

    # (e.g. "Average Age: 34")
  end

  it "lists space missions alphabetically for each astronaut" do
    #     User Story 3 of 4
    neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
    buzz = Astronaut.create!(name: "Buzz Aldrin", age: 42, job: "Supreme Commander")
    lightyear = Astronaut.create!(name: "Buzz Lightyear", age: 789, job: "Master Chief")

    capricorn = Mission.create!(title: "Capricorn 4", time_in_space: 18)
    gemini = Mission.create!(title: "Gemini 7", time_in_space: 100)
    apollo = Mission.create!(title: "Apollo 13", time_in_space: 24)

    neil.missions << [capricorn, gemini, apollo]
    buzz.missions << [capricorn, gemini]
    lightyear.missions << [gemini, apollo]

    # As a visitor,
    # When I visit the Astronauts index page ('/astronauts')
    visit "/astronauts"
    # I see a list of the space missions' in alphabetical order for each astronaut.
    within("#astronaut-#{neil.id}") do
      expect("Apollo 13").to appear_before("Capricorn 4")
      expect("Capricorn 4").to appear_before("Gemini 7")
    end

    within("#astronaut-#{buzz.id}") do
      expect("Capricorn 4").to appear_before("Gemini 7")
      expect(page).to_not have_content("Apollo")
    end

    within("#astronaut-#{lightyear.id}") do
      expect("Apollo 13").to appear_before("Gemini 7")
      expect(page).to_not have_content("Capricorn")
    end
    # (e.g "Apollo 13"
    #      "Capricorn 4"
    #      "Gemini 7")
  end

  it "shows total time in space for each astronaut" do
    #     User Story 4 of 4
    neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
    buzz = Astronaut.create!(name: "Buzz Aldrin", age: 42, job: "Supreme Commander")
    lightyear = Astronaut.create!(name: "Buzz Lightyear", age: 789, job: "Master Chief")

    capricorn = Mission.create!(title: "Capricorn 4", time_in_space: 18)
    gemini = Mission.create!(title: "Gemini 7", time_in_space: 100)
    apollo = Mission.create!(title: "Apollo 13", time_in_space: 24)

    neil.missions << [capricorn, gemini, apollo]
    buzz.missions << [capricorn, gemini]
    lightyear.missions << [gemini, apollo]
    # As a visitor,
    # When I visit the Astronauts index page ('/astronauts')
    visit "/astronauts"
    # I see the total time in space for each astronaut.
    expect(page).to have_content("Name: Neil Armstrong, Age: 37, Job: Commander, Total Time in Space: 142 days")
    expect(page).to have_content("Name: Buzz Aldrin, Age: 42, Job: Supreme Commander, Total Time in Space: 118 days")
    expect(page).to have_content("Name: Buzz Lightyear, Age: 789, Job: Master Chief, Total Time in Space: 124 days")
    # (e.g. "Name: Neil Armstrong, Age: 37, Job: Commander, Total Time in Space: 760 days")
  end
end