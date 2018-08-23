class Location < ApplicationRecord
	#These validations would be nice
	#validates :zipcode, presence: true, numericality: {only_integer: true }
	serialize :weather_data, Hash
	require 'net/http'	

	#Get an API key to authenticate our requests against Open Weather
	API_KEY = "0876fdaa71375088839595dbcf6a64aa"
	@@zipcode_path = "http://api.openweathermap.org/data/2.5/weather"
	
	
	#Trying zipcode request encoding the params
	def build_weather
		#@zipcode ||= zipcode
		uri = URI(@@zipcode_path)
		params = {:zip => zipcode, :country_code => 'us', :units => 'imperial', :APPID => API_KEY}
		uri.query = URI.encode_www_form(params)
		res = Net::HTTP.get_response(uri)
		json_resp = JSON.parse(res.body)
end

end
