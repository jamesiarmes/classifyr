class CreateDataSources < ActiveRecord::Migration[7.0]
  def change
    create_table :data_sources do |t|
      t.string :type
      t.string :name
      t.string :api_domain
      t.string :api_resource
      t.string :api_key

      t.timestamps
    end

    add_reference :data_sets, :data_source, null: false, polymorphic: true
  end
end
