FactoryGirl.define do
  factory :schedule do
    date {rand(1..100).days.from_now.to_date}

    shift
    driver
  end
end
