class AddColumnsToCommonIncidentTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :common_incident_types, :humanized_code, :string
    add_column :common_incident_types, :humanized_description, :string
  end
end
