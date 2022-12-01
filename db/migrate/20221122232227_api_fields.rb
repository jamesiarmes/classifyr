class ApiFields < ActiveRecord::Migration[7.0]
  def change
    # Add API configuration fields.
    add_column :data_sets, :api_domain, :string
    add_column :data_sets, :api_resource, :string
    add_column :data_sets, :api_key, :string
  end
end
