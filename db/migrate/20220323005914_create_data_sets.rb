class CreateDataSets < ActiveRecord::Migration[7.0]
  def change
    create_table :data_sets do |t|
      t.string :name
      t.text   :description
      t.string :city
      t.string :state
      t.integer :rows
      t.string :headers
      t.boolean :analyzed

      t.timestamps
    end
  end
end
