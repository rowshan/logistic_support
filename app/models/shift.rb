class Shift < ApplicationRecord
 has_and_belongs_to_many :time_windows
 belongs_to :plant

 validates_presence_of :name, :start_time, :end_time, :plant_id
end
