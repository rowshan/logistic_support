class Trip < ApplicationRecord
  belongs_to :trip_kind
  belongs_to :time_window

  validates_presence_of :trip_kind_id,:time_window_id,:address_id
  validates_uniqueness_of :trip_kind_id
end
