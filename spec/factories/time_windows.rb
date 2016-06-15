FactoryGirl.define do
  factory :time_window do
    tenant_id { SecureRandom.uuid }
    label { "label#{SecureRandom.hex}" }
    start_time {(Time.at(12.hours.from_now)).strftime("%H:%M")}
    end_time {(Time.at(24.hours.from_now)).strftime("%H:%M")}
  end
end