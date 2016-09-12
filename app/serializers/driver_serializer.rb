class DriverSerializer < ApplicationSerializer
  attributes :id, :first_name,:last_name,:phone_no,:plant_id,:user_id,:enabled, :url

  belongs_to :plant

  def url
    url_helpers.driver_path(object)
  end

end
