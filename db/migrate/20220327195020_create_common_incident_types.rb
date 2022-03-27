class CreateCommonIncidentTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :common_incident_types do |t|
      t.string :standard, default: 'APCO'
      t.string :version, default: '2.103.2-2019'
      t.string :code
      t.string :description
      t.string :notes

      t.timestamps
    end
  end
end
