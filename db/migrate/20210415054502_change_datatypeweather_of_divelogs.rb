class ChangeDatatypeweatherOfDivelogs < ActiveRecord::Migration[5.2]
  def change
    change_column :Divelogs, :weather, :text
  end
end
