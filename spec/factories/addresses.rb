FactoryGirl.define do
  factory :address do
    salutation { %w(Mr Mrs Herr Frau).sample }
    first_name { "First#{SecureRandom.hex}" }
    last_name { "Last#{SecureRandom.hex}" }
    company { "#{SecureRandom.hex}" }
    street { "Street #{SecureRandom.hex}" }
    house_no_main { rand(20).to_s }
    house_no_add { ('A'..'G').to_a.sample }
    other { "" }
    postal_code { (0 .. rand(5..10)).map{ "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".chars.sample }.join }
    postal_code_id { SecureRandom.uuid }
    city { "City#{SecureRandom.hex}" }
    city_id { SecureRandom.uuid }
    province { "Province#{SecureRandom.hex}" }
    province_id { SecureRandom.uuid }
    country { "Country#{SecureRandom.hex}" }
    country_code { "#{('A'..'Z').to_a.sample}#{('A'..'Z').to_a.sample}"}
    country_id { SecureRandom.uuid }
  end
end
