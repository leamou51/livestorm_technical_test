class CreateAdventurers < ActiveRecord::Migration[5.1]
  def change
    create_table :adventurers do |t|
      t.string :name
      t.integer :strength
      t.integer :sagacity
      t.integer :luck
      t.integer :trickery
      t.string :attacks
      t.string :shields
      t.string :quote
      t.timestamps
    end
  end
end
