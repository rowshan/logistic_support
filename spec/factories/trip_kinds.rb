FactoryGirl.define do
  factory :trip_kind do
    name { "Name#{SecureRandom.hex}" }
    description { "Des#{SecureRandom.hex}" }

  end
end
