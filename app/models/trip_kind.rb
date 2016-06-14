class TripKind < ApplicationRecord
  has_many :trips
  validates_presence_of :name
end
