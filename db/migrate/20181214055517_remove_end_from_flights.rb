class RemoveEndFromFlights < ActiveRecord::Migration[5.2]
  def change
    remove_column :flights, :end
  end
end
