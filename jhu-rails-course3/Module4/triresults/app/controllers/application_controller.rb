class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  rescue_from ActionView::MissingTemplate do |exception| 
  	Rails.logger.debug exception
  	render :status=> :unsupported_media_type,
  				 :plain=>"woops: we do not support that content-type[#{request.accept}]"
  end

  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
		render	:status=> :not_found,
						:template=>"api/error",
						:locals=>{:msg=>"woops: cannot find race[#{params[:id]}]"}
	end

end
