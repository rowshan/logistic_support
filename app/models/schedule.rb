class Schedule < ApplicationRecord
  belongs_to :driver
  belongs_to :shift

  validates_presence_of :date, :shift_id, :driver_id

end
