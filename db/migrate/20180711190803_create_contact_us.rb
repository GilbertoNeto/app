class CreateContactUs < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_us do |t|
      t.string :name
      t.string :email
      t.string :telefone
      t.string :motivo
      t.string :descricao

      t.timestamps
    end
  end
end
