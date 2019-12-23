class Api::RacesController < ApplicationController 

  # GET api/races
  # GET api/races.json
  def index
  	if !request.accept || request.accept == "*/*"
  		rtn_str ="/api/races"
  		rtn_str += ", offset=[#{params[:offset]}]" if params[:offset]
  		rtn_str += ", limit=[#{params[:limit]}]" if params[:limit]
			render plain: rtn_str
		else
		  #real implementation ...

		end
  end

  # GET api/races/1
  # GET api/races/1.json
  def show
		if !request.accept || request.accept == "*/*"
			render plain: "/api/races/#{params[:id]}" 
		else
		  @race = Race.find_by(:id=>params[:id])
		  render template: 'races/show'
		end
  end

  # POST api/race
  def create
  	if !request.accept || request.accept == "*/*"
  		rtn_str = "/api/races"
  		rtn_str = params[:race][:name] if params[:race]
  		render plain: rtn_str, status: :ok
  	else
  		race = Race.create!(race_params)
  		render plain: race.name, status: :created
  	end
  end

  # PUT/PATCH api/races/:id
  def update
  	# if !request.accept || request.accept == "*/*"
  	# 	render plain: "/api/races/#{params[:id]}", status: :ok
  	# else
  	Rails.logger.debug("method=#{request.method}")
		race = Race.find(params[:id])
		race.update!(race_params)
		render json: race, status: :ok
  	# end

  end

  def destroy
  	race = Race.find(params[:id])
  	if !race.nil?
  		race.destroy
  		render :nothing=>true, :status => :no_content
  	else
  		render :nothing=>true
  	end
  end


  private

	  def race_params
	    params.require(:race).permit(:name, :date)
	  end

end
