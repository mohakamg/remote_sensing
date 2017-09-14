class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :org_id
      t.string :name
      t.string :phone
      t.string :org_type, array: true

      t.timestamps
    end
  end
end
