class CreateSensors < ActiveRecord::Migration[5.1]
  def change
    create_table :sensors do |t|
      t.string :sens_id
      t.references :organization, foreign_key: true
      t.string :sens_name

      t.timestamps
    end
  end
end
