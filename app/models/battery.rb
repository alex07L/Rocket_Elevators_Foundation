class Battery < ApplicationRecord
  belongs_to :type
  belongs_to :employee
  belongs_to :building
  has_many :column
  has_many :intervention
  belongs_to :status
end
