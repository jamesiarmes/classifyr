class DataSet < ApplicationRecord
  has_many_attached :files
  has_many :fields

  def prepare_datamap
    if fields.empty?
      set_metadata!
      # check there's an attached file
      files.first.headers.split(',').each_with_index do |heading, i|
        files.first.with_file do |f|
          unique_value_count = `cut -d, -f#{i+1} #{f.path} | sort | uniq | wc -l` - 1
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

    # CHECK FILES HAVE SAME FORMAT / HEADER FIELDS
    # OR ADD ERRORS
  end

  def analyze_files!
    files.each do |file|
      file.analyze!
    end
    # duplicate records
    # fields headings
    # start and end date
  end
end
