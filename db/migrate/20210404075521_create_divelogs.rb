class CreateDivelogs < ActiveRecord::Migration[5.2]
  def change
    create_table :divelogs do |t|
      t.string :name
      t.text :description
      t.float :depth
      t.float :water_temp
      t.float :temp
      t.integer :weather
      t.float :visibility
      t.text :reference
      t.integer :popularity
      t.text :dive_memo
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :divelogs, [:user_id, :created_at]
  end
end
