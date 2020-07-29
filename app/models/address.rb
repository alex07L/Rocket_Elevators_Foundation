class Address < ApplicationRecord

after_create :update_coord
  require 'google_maps_service'
  require 'json'
  def update_coord
	gmaps = GoogleMapsService::Client.new(key: ENV['GOOGLE'])
	results = gmaps.geocode(self.street+","+self.city+","+self.country)
	#	puts results[0][:geometry][:location][:lat]
	self.update_attribute(:lat, results[0][:geometry][:location][:lat])
	self.update_attribute(:long, results[0][:geometry][:location][:lng])
  end
end
