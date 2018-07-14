class AddDataCanceladoToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :cancelado, :timestamp
  end
end
