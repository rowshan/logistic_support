FactoryGirl.define do
  factory :trip do
    order_id {SecureRandom.uuid}
    date {rand(1..100).days.from_now.to_date}
    start_time { (Date.today + rand(5..22).hour + 0.minutes).to_time }
    end_time { start_time ? start_time + 1.hour : nil }
    trip_kind

  end
end
