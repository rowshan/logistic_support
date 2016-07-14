class Driver < ApplicationRecord
  belongs_to :plant
  has_many :schedules

  validates_presence_of :first_name,:last_name,:plant_id
end
