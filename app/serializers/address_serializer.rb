class AddressSerializer < ApplicationSerializer
  attributes :id, :salutation, :first_name, :last_name, :street, :house_no_main, :house_no_add, :other
  attributes :postal_code, :city, :province, :country_code, :country
  attributes :url

  has_one :trip
  def url
    url_helpers.trip_address_path(object.trip, object)
  end
end
