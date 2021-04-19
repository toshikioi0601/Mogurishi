class ChangeDivelogsToDivelogs < ActiveRecord::Migration[5.2]
  def change
    rename_table :divelogs, :test
    rename_table :test, :divelogs
  end
end
