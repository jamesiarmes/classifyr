class CreateUniqueValues < ActiveRecord::Migration[7.0]
  def change
    create_table :unique_values do |t|
      t.references :field
      t.string :value
      t.integer :frequency
    end
  end
end
