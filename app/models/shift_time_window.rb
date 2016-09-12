class ShiftTimeWindow < ApplicationRecord
  self.table_name = :shifts_time_windows

  belongs_to :shift
  belongs_to :time_window

end
