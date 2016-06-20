class ShiftSerializer < ApplicationSerializer
  attributes :id, :time_window_id, :name, :start_time, :end_time, :send_time, :enabled, :plant_id, :url

  belongs_to :time_window
  belongs_to :plant

  def url
    url_helpers.shift_path(object)
  end

  def start_time
    object.start_time.strftime("%H:%M")

  end

  def end_time
    object.end_time.strftime("%H:%M")
    end

  def send_time
    object.send_time.strftime("%H:%M")
  end

end
