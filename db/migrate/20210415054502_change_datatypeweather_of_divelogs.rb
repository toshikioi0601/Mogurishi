class ChangeDatatypeweatherOfDivelogs < ActiveRecord::Migration[5.2]
  def change
    change_column :divelogs, :weather, :text
  end
end
