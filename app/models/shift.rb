class Shift < ApplicationRecord
 Time='UTC'
 belongs_to :time_window

  validates_presence_of :time_window_id, :name, :start_time, :end_time
end
