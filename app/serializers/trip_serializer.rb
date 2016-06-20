class TripSerializer < ApplicationSerializer
  attributes :id, :trip_kind_id, :order_id, :date, :time_window_id, :url

  belongs_to :trip_kind
  belongs_to :time_window
  has_one :address

  def url
    url_helpers.trip_path(object)
  end
end
