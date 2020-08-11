class Column < ApplicationRecord
  belongs_to :battery
  has_many :elevator
  has_many :intervention
  belongs_to :status
end
