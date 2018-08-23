class LocationsController < ApplicationController
	
	def lookup
		#Gets JSON response back
		puts params.inspect
		unless params[:zipcode].blank? 
			@zipcode = location_params[:zipcode]
			@location = Location.find_or_create_by(zipcode: @zipcode.to_i)
			@location.weather_data = @location.build_weather
			@location.save!
		else
			@location = Location.new
		end
	end
	
	private

	def location_params
		params.permit(:zipcode)
	end

end
