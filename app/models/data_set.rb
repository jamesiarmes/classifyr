class DataSet < ApplicationRecord
  has_many_attached :files
  has_many :fields

  attr_accessor :step

  def datafile
    files.first
  end

  def prepare_datamap
    if fields.empty?
      set_metadata!
      # check there's an attached file
      datafile.headers.split(',').each_with_index do |heading, i|
        datafile.with_file do |f|
          unique_value_count = `cut -d, -f#{i+1} #{f.path} | sort | uniq | wc -l`.to_i - 1
          blank_value_count = `cut -d, -f#{i+1} #{f.path} | grep -v -e '[[:space:]]*$' | wc -l`
          sample_data = `tail -n +2 #{f.path} | cut -d, -f#{i+1} | sort | uniq | head`
          fields.create heading: heading, position: i, unique_value_count: unique_value_count,
                        empty_value_count: blank_value_count, sample_data: sample_data
        end
      end
    end
  end

  def set_metadata!
    files.each do |file|
      file.set_metadata!
    end
  end

  def analyze!
    ordered_fields = fields.order('position asc')

    datafile.with_file do |f|
      fields.mapped.each do |field|
        if field.common_type == 'Call Time'
          # parse dates and find earliest / latest
        end

        next unless Field::VALUE_TYPES.include? field.common_type
        field.min_value = `tail -n +2 police-incidents-2022.csv | cut -d, -f#{field.position} | sort | uniq | head -1`&.chomp
        field.max_value = `tail -n +2 police-incidents-2022.csv | cut -d, -f#{field.position} | sort | uniq | tail -1`&.chomp
        field.save!
      end
    end
  end
end
