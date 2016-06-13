FactoryGirl.define do
  factory :shift do
    name { "Name#{SecureRandom.hex}" }
    time_window_id { SecureRandom.uuid }
    start_time { Time.at(12.hours.from_now )}
    end_time { Time.at(18.hours.from_now )}
    send_time { Time.at(11.hours.from_now) }
    enabled { [true, false].sample }

    end

end
