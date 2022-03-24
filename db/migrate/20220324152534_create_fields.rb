class CreateFields < ActiveRecord::Migration[7.0]
  def change
    create_table :fields do |t|
      t.references :data_set
      t.string :heading
      t.integer :position
      t.string :common_type
      t.string :common_format
      t.integer :unique_value_count
      t.integer :empty_value_count
      t.text  :sample_data

      t.timestamps
    end
  end
end
