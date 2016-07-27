class Shift < ApplicationRecord
  has_and_belongs_to_many :time_windows
  belongs_to :plant
  has_many :schedules

  validates_presence_of :name, :start_time, :end_time, :plant_id

  # expects a Date.wday (NOT cwday); Sun:0, Mon:1, ... , Sat:6
  def available?(wday)
    return (self.availability.to_s.to_i(2) & (2**wday)) > 0
  end
end
