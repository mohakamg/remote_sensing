class CreateData < ActiveRecord::Migration[5.1]
  def change
    create_table :data do |t|
      t.references :organization, foreign_key: true
      t.references :sensor, foreign_key: true
      t.string :organiz_id
      t.string :sens_id
      t.string :value
      t.string :unit

      t.timestamps
    end
  end
end
