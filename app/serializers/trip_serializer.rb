class TripSerializer < ApplicationSerializer
  attributes :id, :order_id, :date, :start_time, :end_time, :url

  belongs_to :trip_kind
  has_one :address

  def url
    url_helpers.trip_path(object)
  end

  def start_time
    object.start_time.strftime("%H:%M")

  end

  def end_time
    object.end_time.strftime("%H:%M")
  end
end
