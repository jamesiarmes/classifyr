class AddFieldsToActiveStorageAttachments < ActiveRecord::Migration[7.0]
  def change
    add_column :active_storage_attachments, :row_count, :integer, default: 0
    add_column :active_storage_attachments, :headers, :string
    add_column :active_storage_attachments, :start_date, :date
    add_column :active_storage_attachments, :end_date, :date
  end
end
