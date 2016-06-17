class TimeWindowSerializer < ApplicationSerializer
  attributes :id, :label, :start_time, :end_time, :tenant_id, :url

  has_many :shifts
  has_many :trips

  def url
    url_helpers.time_window_path(object)
  end
end