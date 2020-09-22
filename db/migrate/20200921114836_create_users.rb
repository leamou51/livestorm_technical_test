class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :score, default: 0
      t.integer :health_point, default: 5
      t.references :adventurer, foreign_key: true
      t.timestamps
    end
  end
end
