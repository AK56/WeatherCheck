class Location < ApplicationRecord
	#These validations would be nice
	#validates :zipcode, presence: true, numericality: {only_integer: true }
	serialize :weather_data, Hash
	require 'net/http'	

	#Get an API key to authenticate our requests against Open Weather
	ACTIVE_PERIOD = 1.hour
	API_KEY = "0876fdaa71375088839595dbcf6a64aa"
	@@zipcode_path = "http://api.openweathermap.org/data/2.5/weather"
	
	def get_or_build_location_weather(zipcode)
		Rails.cache.fetch("weather_at_#{zipcode}", expires_in: 30.minutes) do
			@location = Location.find_or_create_by(zipcode: zipcode)
			@location.build_weather
			@location
		end
	end
	
	def build_weather
		puts self.inspect
		uri = URI(@@zipcode_path)
		params = {:zip => self.zipcode, :country_code => 'us', :units => 'imperial', :APPID => API_KEY}
		uri.query = URI.encode_www_form(params)
		res = Net::HTTP.get_response(uri)
		self.expires_at = Time.now + ACTIVE_PERIOD
		self.weather_data = JSON.parse(res.body)
		self.save!
	end

	def Location.destroy_stale_records
		#For Maintenance: This call can be made to destroy all records who haven't been touched since your choice of time
		#For example, 1 hour
		Location.find_each do |l|
			l.destroy if l.expires_at.localtime < Time.now - ACTIVE_PERIOD
		end
	end
end
