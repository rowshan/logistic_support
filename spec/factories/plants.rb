FactoryGirl.define do
  factory :plant do
    company { "#{SecureRandom.hex}" }
    email { "Email#{SecureRandom.hex}" }
    phone_no { "Phone#{SecureRandom.hex}" }
    address { "Address#{SecureRandom.hex}" }
    tenant_id {SecureRandom.uuid}


  end
end
