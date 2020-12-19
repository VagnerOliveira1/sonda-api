class CreateSondas < ActiveRecord::Migration[6.0]
  def change
    create_table :sondas do |t|
      t.string :face
      t.integer :coordinate_x
      t.integer :coordinate_y

      t.timestamps
    end
  end
end
