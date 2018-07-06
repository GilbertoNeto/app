class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :numero
      t.date :validade
      t.string :bandeira
      t.integer :cvv
      t.string :titular
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
