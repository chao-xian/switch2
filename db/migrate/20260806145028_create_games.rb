class CreateGames < ActiveRecord::Migration[8.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :link
      t.datetime :added_at
      t.string :format
      t.integer :rating
      t.string :platform
      t.boolean :compatible, default: false, null: false

      t.timestamps
    end

    add_index :games, :link, unique: true
  end
end
