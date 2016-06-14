FactoryGirl.define do
  factory :shift do
    name { "Name#{SecureRandom.hex}" }
    time_window_id { SecureRandom.uuid }
    start_time {12.hours.from_now}
    end_time { 18.hours.from_now}
    send_time {11.hours.from_now }
    enabled { [true, false].sample }

    time_window

    end
end
