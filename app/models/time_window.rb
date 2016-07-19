class TimeWindow < ApplicationRecord
  has_and_belongs_to_many :shifts

  validates_presence_of :tenant_id, :start_time, :end_time
end
