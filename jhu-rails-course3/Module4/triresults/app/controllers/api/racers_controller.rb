class Api::RacersController < ApplicationController 

  # GET api/racers
  # GET api/racers.json
  def index
		if !request.accept || request.accept == "*/*"
			render plain: "/api/racers" 
		else
		  #real implementation ...
		end
  end

  # GET api/racers/1
  # GET api/racers/1.json
  def show
  	if !request.accept || request.accept == "*/*"
			render plain: "/api/racers/#{params[:id]}" 
		else
		  #real implementation ...
		end  	
  end

end
