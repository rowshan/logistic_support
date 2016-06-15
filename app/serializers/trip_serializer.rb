class TripSerializer < ApplicationSerializer
  attributes :id,:trip_kind_id, :order_id, :date, :time_window_id, :address_id

  belongs_to :trip_kind
  belongs_to :time_window


  def url
    url_helpers.trip_path(object)
  end
end
