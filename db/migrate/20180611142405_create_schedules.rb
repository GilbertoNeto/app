class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.time :hour
      t.date :date
      t.integer :evaluation
      t.references :customer, foreign_key: true
      t.references :business, foreign_key: true

      t.timestamps
    end
  end
end
