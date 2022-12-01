# frozen_string_literal: true

FactoryBot.define do
  factory(:field) do
    association :data_set, :with_csv
    heading { Faker::Lorem.word }
    common_type { Field::VALUE_TYPES[1] }

    trait :with_unique_values do
      unique_values { create_list(:unique_value, 3) }
    end
  end
end
