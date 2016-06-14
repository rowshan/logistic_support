class TripKindSerializer < ApplicationSerializer
  attributes :id,:name,:description,:url

  has_many :trips
  def url
    url_helpers.trip_kind_path(object)
  end


end
