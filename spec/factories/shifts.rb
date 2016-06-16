FactoryGirl.define do
  factory :shift do
    name { "Name#{SecureRandom.hex}" }
    time_window_id { SecureRandom.uuid }
    start_time { "Start#{SecureRandom.hex}" }
    end_time { "End#{SecureRandom.hex}" }
    send_time { "Send#{SecureRandom.hex}" }
    enabled { [true, false].sample }

    time_window

    end
end
