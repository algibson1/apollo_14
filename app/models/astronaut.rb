class Astronaut < ApplicationRecord
  validates_presence_of :name, :age, :job

  has_many :astronaut_missions
  has_many :missions, through: :astronaut_missions

  def self.average_age 
    average(:age).round(2) unless Astronaut.all.empty?
  end

  def alphabetical_missions
    missions.order("title ASC")
  end

  def total_time_in_space
    missions.sum(:time_in_space)
  end
end
