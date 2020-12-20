class AddCommandsToSondas < ActiveRecord::Migration[6.0]
  def change
    add_column :sondas, :commands, :text, array: true, default: []
  end
end
