class PlantSerializer < ApplicationSerializer
  attributes :id,:company,:email,:phone_no,:address,:tenant_id,:url

  has_many :shifts
  has_many :drivers

  def url
    url_helpers.plant_path(object)
  end

end



