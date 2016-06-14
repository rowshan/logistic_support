class Trip < ApplicationRecord
  belongs_to :trip_kind

  validates_presence_of :trip_kind_id,:order_id,:time_window_id,:address_id
  validates_uniqueness_of :trip_kind_id
end
