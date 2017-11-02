class AddDateAddedToData < ActiveRecord::Migration[5.1]
  def change
    add_column :data, :date_upload, :datetime
  end
end
