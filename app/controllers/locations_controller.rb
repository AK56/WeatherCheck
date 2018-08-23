class LocationsController < ApplicationController
	
	def lookup
		#Gets JSON response back
		@location = Location.new
		unless params[:zipcode].blank? 
			@zipcode = location_params[:zipcode]
			@from_cache = Rails.cache.read("weather_at_#{@zipcode}")
			@location = @location.get_or_build_location_weather(@zipcode.to_i)
		end
	end
	
	private

	def location_params
		params.permit(:zipcode)
	end

end
