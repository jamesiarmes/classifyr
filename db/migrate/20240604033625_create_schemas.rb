class CreateSchemas < ActiveRecord::Migration[7.1]
  def change
    create_table :schemas do |t|
      t.string :title
      t.string :slug, index: { unique: true }

      t.timestamps
    end
  end
end
