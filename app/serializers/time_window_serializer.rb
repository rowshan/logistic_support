class TimeWindowSerializer < ApplicationSerializer
  attributes :id, :label, :start_time, :end_time, :tenant_id, :url

  has_many :shifts

  def url
    url_helpers.time_window_path(object)
  end

  def start_time
    object.start_time.strftime("%H:%M")

  end

  def end_time
    object.end_time.strftime("%H:%M")
  end
end
