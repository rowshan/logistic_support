class TimeWindowSerializer < ApplicationSerializer
  attributes :id, :label, :start_time, :end_time, :tenant_id, :url

  has_many :time_windows
  def url
    url_helpers.time_window_path(object)
  end
end
