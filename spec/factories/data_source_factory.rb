# frozen_string_literal: true

FactoryBot.define do
  factory :csv_file do
    type { 'CsvFile' }
    name { 'CSV File' }
    files { [Rack::Test::UploadedFile.new('spec/support/files/police-incidents-2022.csv', 'text/csv')] }
  end


  factory :socrata do
    type { 'Socrata' }
    name { 'Socrata API' }
    api_domain { 'data.example.org' }
    api_resource { 'test-spec' }
    api_key { nil }
  end
end
