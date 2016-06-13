FactoryGirl.define do
  factory :time_window do
    tenant_id { SecureRandom.uuid }
    label { "label#{SecureRandom.hex}" }
    start_time {1.days.from_now.to_i}
    end_time {1.days.from_now.to_i}

  end
end