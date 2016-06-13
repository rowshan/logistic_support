class TimeWindow < ApplicationRecord
  has_many :shifts

  validates_presence_of :tenant_id
end
