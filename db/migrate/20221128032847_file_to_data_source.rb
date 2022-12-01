class FileToDataSource < ActiveRecord::Migration[7.0]
  def up
    DataSet.find_each do |data_set|
      next if data_set.data_source

      data_set.data_source = DataSource.create
      data_set.data_source.type = 'CsvFile'
      data_set.save!

      data_set.files.each do |file|
        file.record = data_set.data_source
        file.save
      end
    end
  end

  def down
    DataSet.find_each do |data_set|
      next unless data_set.data_source.type == 'CsvFile'

      data_set.data_source.files.each do |file|
        file.record = data_set
        file.save
      end

      data_set.data_source.delete
    end
  end
end
