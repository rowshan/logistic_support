FactoryGirl.define do
  factory :time_window do
    tenant_id { SecureRandom.uuid }
    label { "label#{SecureRandom.hex}" }


  end
end