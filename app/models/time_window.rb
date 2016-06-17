class TimeWindow < ApplicationRecord
  Time='UTC'
  has_many :shifts
  has_many :trips

  validates_presence_of :tenant_id
end