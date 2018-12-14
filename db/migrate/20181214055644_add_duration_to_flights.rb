class AddDurationToFlights < ActiveRecord::Migration[5.2]
  def change
    add_column :flights, :duration, :integer
  end
end
