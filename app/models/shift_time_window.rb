class ShiftTimeWindow < ApplicationRecord
  belongs_to :shift
  belongs_to :time_window

end
