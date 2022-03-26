class CreateDataSets < ActiveRecord::Migration[7.0]
  def change
    create_table :data_sets do |t|
      t.string :title
      t.string :data_link
      t.string :documentation_link
      t.string :api_links
      t.string :source
      t.string :exclusions
      t.string :format
      t.text   :license
      t.text   :description
      t.string :city
      t.string :state
      t.string :headers
      t.boolean :has_911
      t.boolean :has_fire
      t.boolean :has_ems
      t.boolean :analyzed

      t.timestamps
    end
  end
end
