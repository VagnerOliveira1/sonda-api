class AddMessageToSondas < ActiveRecord::Migration[6.0]
  def change
    add_column :sondas, :message, :text
  end
end
