class Shift < ApplicationRecord
 belongs_to :time_window
 belongs_to :plant

  validates_presence_of :time_window_id, :name, :start_time, :end_time,:plant_id
end
