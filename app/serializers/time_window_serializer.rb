class TimeWindowSerializer < ApplicationSerializer
  attributes :id, :label, :start_time, :end_time, :tenant_id, :url


  def url
    url_helpers.time_window_path( object)
  end
end
