class Driver < ApplicationRecord
  belongs_to :plant

  validates_presence_of :first_name,:last_name,:plant_id
end
