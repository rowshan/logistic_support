class TimeWindow < ApplicationRecord
  has_and_belongs_to_many :shifts
  has_many :trips

  validates_presence_of :tenant_id
end
