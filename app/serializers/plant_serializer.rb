class PlantSerializer < ApplicationSerializer
  attributes :id,:company,:email,:phone_no,:address,:tenant_id,:url

  has_many :shifts

  def url
    url_helpers.plant_path(object)
  end

end



