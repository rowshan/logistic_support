FactoryGirl.define do
  factory :trip do
    trip_kind_id {SecureRandom.uuid}
    order_id {SecureRandom.uuid}
    time_window_id {SecureRandom.uuid}
    address_id {SecureRandom.uuid}
    date {SecureRandom.hex}

    trip_kind
  end
end
