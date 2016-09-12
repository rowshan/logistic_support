FactoryGirl.define do
  factory :driver do
    first_name { "First#{SecureRandom.hex}" }
    last_name { "Last#{SecureRandom.hex}" }
    enabled { [true, false].sample }
    user_id { SecureRandom.uuid }
    plant
  end
end
