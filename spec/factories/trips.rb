FactoryGirl.define do
  factory :trip do
    order_id {SecureRandom.uuid}
    date {rand(1..100).days.from_now.to_date}

    trip_kind
    time_window

  end
end
