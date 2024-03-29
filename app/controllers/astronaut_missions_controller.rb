class AstronautMissionsController < ApplicationController
  def create 
    AstronautMission.create(astronaut_id: params[:id], mission_id: params[:mission_id])
    redirect_to "/astronauts/#{params[:id]}"
  end
end