class ScheduleSerializer < ApplicationSerializer
  attributes :date, :url

  belongs_to :shift
  belongs_to :driver

  def url
    url_helpers.schedule_path(object)
  end
end
