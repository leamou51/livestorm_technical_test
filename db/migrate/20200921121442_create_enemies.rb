class CreateEnemies < ActiveRecord::Migration[5.1]
  def change
    create_table :enemies do |t|
      t.string :name
      t.integer :level
      t.integer :health_point, default: 5
      t.boolean :boss, default: false
      t.timestamps
    end
  end
end
