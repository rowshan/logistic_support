FactoryGirl.define do
  factory :shift do
    name { "Name#{SecureRandom.hex}" }
    send_time {(Time.at(11.hours.from_now)).strftime("%H:%M")}
    start_time {(Time.at(12.hours.from_now)).strftime("%H:%M")}
    end_time {(Time.at(24.hours.from_now)).strftime("%H:%M")}
    enabled { [true, false].sample }

    time_window

    end
end
