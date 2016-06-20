FactoryGirl.define do
  factory :shift do
    name { "Name#{SecureRandom.hex}" }
    start_time {rand(1..100).hours.from_now.strftime("%H:%M")}
    end_time {rand(1..100).hours.from_now.strftime("%H:%M")}
    send_time {rand(1..100).hours.from_now.strftime("%H:%M")}
    enabled { [true, false].sample }

    time_window
    plant

    end
end
