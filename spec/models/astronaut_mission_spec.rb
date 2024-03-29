require "rails_helper"

RSpec.describe AstronautMission do 
  describe "relationships" do
    it { should belong_to :astronaut }
    it { should belong_to :mission }
  end
end