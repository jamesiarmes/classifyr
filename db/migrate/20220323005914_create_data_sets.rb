class CreateDataSets < ActiveRecord::Migration[7.0]
  def change
    create_table :data_sets do |t|
      t.string :name
      t.string :city
      t.string :state
      t.datetime :start_date
      t.datetime :end_date
      t.integer :rows
      t.string :headers


      t.timestamps
    end
  end
end
