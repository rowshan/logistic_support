class Trip < ApplicationRecord
  belongs_to :trip_kind
  has_one :address

  validates_presence_of :trip_kind_id, :order_id, :date, :start_time, :end_time

end
