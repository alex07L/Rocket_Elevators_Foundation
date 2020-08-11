class Building < ApplicationRecord
  belongs_to :address
  belongs_to :customer
  has_many :battery
  has_many :building_detail
  has_many :intervention
  include RailsAdminWeather
  
  def self.data
	[
		name: "Weather",
		apiKey: ENV['WEATHER']
	]
  end
end
