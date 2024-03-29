require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  describe "class methods" do
    describe "::average_age" do 
      it "calculates average age" do
        neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
        buzz = Astronaut.create!(name: "Buzz Aldrin", age: 42, job: "Supreme Commander")
        lightyear = Astronaut.create!(name: "Buzz Lightyear", age: 789, job: "Master Chief")

        expect(Astronaut.average_age).to eq(289.33)
      end
    end
  end

  describe "instance methods" do
    describe "#alphabetical_missions" do
      it "sorts missions alphabetically" do
        neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
        buzz = Astronaut.create!(name: "Buzz Aldrin", age: 42, job: "Supreme Commander")
        lightyear = Astronaut.create!(name: "Buzz Lightyear", age: 789, job: "Master Chief")
    
        capricorn = Mission.create!(title: "Capricorn 4", time_in_space: 18)
        gemini = Mission.create!(title: "Gemini 7", time_in_space: 100)
        apollo = Mission.create!(title: "Apollo 13", time_in_space: 24)
    
        neil.missions << [capricorn, gemini, apollo]
        buzz.missions << [capricorn, gemini]
        lightyear.missions << [gemini, apollo]

        expect(neil.alphabetical_missions).to eq([apollo, capricorn, gemini])
        expect(buzz.alphabetical_missions).to eq([capricorn, gemini])
        expect(lightyear.alphabetical_missions).to eq([apollo, gemini])
      end
    end

    describe "#total_time_in_space" do
      it "calculates total time in space" do
        neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
        buzz = Astronaut.create!(name: "Buzz Aldrin", age: 42, job: "Supreme Commander")
        lightyear = Astronaut.create!(name: "Buzz Lightyear", age: 789, job: "Master Chief")
    
        capricorn = Mission.create!(title: "Capricorn 4", time_in_space: 18)
        gemini = Mission.create!(title: "Gemini 7", time_in_space: 100)
        apollo = Mission.create!(title: "Apollo 13", time_in_space: 24)
    
        neil.missions << [capricorn, gemini, apollo]
        buzz.missions << [capricorn, gemini]
        lightyear.missions << [gemini, apollo]

        expect(neil.total_time_in_space).to eq(142)
        expect(buzz.total_time_in_space).to eq(118)
        expect(lightyear.total_time_in_space).to eq(124)
      end
    end
  end
end
