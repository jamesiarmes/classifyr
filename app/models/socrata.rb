# frozen_string_literal: true

require 'soda'

# Socrata API data source.
class Socrata < DataSource
  TYPE_NAME = 'Socrata API'

  validates :api_domain, presence: true
  validates :api_resource, presence: true

  def record_count
    client.get(api_resource, '$select': 'COUNT(*) AS count').body.first['count'].to_i
  end

  def prepare_datamap # rubocop:disable Metrics/AbcSize
    details = client.get("/api/views/#{api_resource}.json").body
    details.columns.each do |column|
      contents = column['cachedContents']
      data_set.fields.create(
        heading: column['name'],
        position: column['position'],
        unique_value_count: contents&.[]('cardinality'),
        empty_value_count: contents&.[]('null'),
        min_value: contents&.[]('smallest'),
        max_value: contents&.[]('largest'),
        sample_data: contents&.[]('top')&.[](0..9)&.map(&:item)
      )
    end
  end

  def analyze!
    data_set.fields.mapped.not_classified.each do |field|
      # If the field has unique values, it has already been analyzed
      next unless Field::VALUE_TYPES.include?(field.common_type) && field.unique_values.none?

      build_unique_values(field)
      field.save!
    end
  end

  def examples(heading:, value:, count: UniqueValue::EXAMPLE_COUNT)
    records = client.get(api_resource,
                         '$where': "#{heading}='#{value}'",
                         '$limit': count).body

    records.map(&:values)
  end

  private

  def client
    @client ||= SODA::Client.new(domain: api_domain)
  end

  def build_unique_values(field)
    client.get(api_resource,
               '$select': "#{field.heading} AS value,COUNT(*) AS count",
               '$group': field.heading).body.each do |value|
      field.unique_values.build value: value['value'], frequency: value['count']
    end
  end
end
