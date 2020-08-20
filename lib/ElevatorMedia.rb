require 'http'
module ElevatorMedia
	class Streamer
		
		def initialize(zip)
			@zipcode=zip
		end
		def getContent
		json = self.call
		return "<div>#{json['current']['temp_c']}</div>"
		end
		
		def call
		url = URI("http://api.weatherapi.com/v1/forecast.json?key=2b23e7071c304d53b82160733203007&q="+@zipcode+"&days=1")
		return JSON.parse(Net::HTTP.get(url))			
		end
	end
end 