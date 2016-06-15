class TimeWindow < ApplicationRecord
  Time='UTC'
  has_many :shifts

  validates_presence_of :tenant_id
end
