class ShiftSerializer < ApplicationSerializer
  attributes :id, :time_window_id, :name, :start_time, :end_time, :send_time, :url

  belongs_to :time_window

  def url
    url_helpers.shift_path(object)
  end

end
