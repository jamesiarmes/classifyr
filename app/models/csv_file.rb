# frozen_string_literal: true

require 'csv'

# CSV file data source.
class CsvFile < DataSource
  TYPE_NAME = 'CSV File'

  has_many_attached :files, dependent: :destroy

  validates :files, attached: true

  def record_count
    files.sum(&:row_count)
  end

  def storage_size
    files.sum(&:byte_size)
  end

  def prepare_datamap
    files.each(&:set_metadata!)
    files.first.with_file do |f|
      contents = ::CSV.read(f, headers: true)
      contents.headers.each_with_index do |heading, i|
        column = contents[heading]
        data_set.fields.create heading:, position: i,
                               unique_value_count: column.uniq.length,
                               empty_value_count: column.count(''),
                               sample_data: column.uniq[0..9]
      end
    end
  end

  def analyze!
    files.first.with_file do |f|
      contents = ::CSV.read(f, headers: true)
      data_set.fields.mapped.not_classified.each do |field|
        build_unique_values(field, contents)
        field_min_max(field, contents)
        field.save!
      end
    end
  end

  def examples(heading:, value:, count: UniqueValue::EXAMPLE_COUNT)
    data = []
    files.first.with_file do |f|
      ::CSV.foreach(f, headers: true) do |row|
        data << row.values_at if row[heading] == value
        break if data.length >= count
      end
    end

    data
  end

  private

  def build_unique_values(field, contents)
    # If the field has unique values, it has already been analyzed
    return unless Field::VALUE_TYPES.include?(field.common_type) && field.unique_values.none?

    contents[field.heading].uniq.each do |value|
      field.unique_values.build value:,
                                frequency: contents[field.heading].count(value)
    end
  end

  def field_min_max(field, contents)
    field.min_value = contents[field.heading].compact.min
    field.max_value = contents[field.heading].compact.max
  end
end
