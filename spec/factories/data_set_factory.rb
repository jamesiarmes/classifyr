# frozen_string_literal: true

FactoryBot.define do
  factory(:data_set) do
    transient do
      files { [Rack::Test::UploadedFile.new('spec/support/files/police-incidents-2022.csv', 'text/csv')] }
    end

    title { Faker::Lorem.word }

    trait :with_csv do
      after(:build) do |data_set, evaluator|
        data_set.data_source = build(:csv_file, files: evaluator.files)
      end

      before(:create) do |data_set|
        data_set.data_source.save!
      end
    end

    trait :with_socrata do
      data_source { create(:socrata) }
    end
  end
end
