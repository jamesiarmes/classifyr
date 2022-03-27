class CreateClassifications < ActiveRecord::Migration[7.0]
  def change
    create_table :classifications do |t|
      t.references :common_incident_type
      t.string :common_type
      t.string :value

      t.timestamps
    end
  end
end
