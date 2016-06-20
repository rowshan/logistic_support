class Plant < ApplicationRecord
  has_many :shifts

  validates_presence_of :company,:email,:phone_no,:address,:tenant_id
end
