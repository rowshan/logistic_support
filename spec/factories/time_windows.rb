FactoryGirl.define do
  factory :time_window do
    tenant_id { SecureRandom.uuid }
    label { "label#{SecureRandom.hex}" }
    start_time { (Date.today + rand(5..22).hour + 0.minute).to_time }
    end_time { start_time ? start_time + 1.hour : nil }

    factory :time_window_with_shifts do
      transient do
        shifts_count 3
      end

      after(:create) do |time_window,evaluator|
        create_list(:shift,evaluator.shifts_count,time_windows: [time_window])
      end
    end

  end
end
