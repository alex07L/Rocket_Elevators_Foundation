require 'http'
module ElevatorMedia
	class Streamer
		
		def initialize(zip)
			@zipcode=zip
		end
		def getContent
		
		return "<div></div>"
		end
		
		def call
		return JSON.parse(HTTP.get("http://api.weatherapi.com/v1/forecast.json?key=2b23e7071c304d53b82160733203007&q="+@zipcode+"&days=7").body)			
		end
	end
end 