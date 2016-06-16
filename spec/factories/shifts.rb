FactoryGirl.define do
  factory :shift do
    name { "Name#{SecureRandom.hex}" }
    start_time {Time.now.strftime("%H:%M")}
    end_time {Time.now.strftime("%H:%M")}
    send_time {Time.now.strftime("%H:%M")}
 # start_time {(Time.at(11.hours.from_now)).strftime("%H:%M")}
 #    end_time {(Time.at(1.day.from_now)).strftime("%H:%M")}
 #    send_time {(Time.at(10.hours.from_now)).strftime("%H:%M")}

    enabled { [true, false].sample }

    time_window

    end
end
