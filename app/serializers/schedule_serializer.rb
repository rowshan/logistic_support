class ScheduleSerializer < ApplicationSerializer
  attributes :id, :date, :url

  def url
    url_helpers.schedule_path(object)
  end
end
