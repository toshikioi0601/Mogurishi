class AddPictureToDivelogs < ActiveRecord::Migration[5.2]
  def change
    add_column :divelogs, :picture, :string
  end
end
