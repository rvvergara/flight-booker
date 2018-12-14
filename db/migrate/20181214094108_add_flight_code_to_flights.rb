class AddFlightCodeToFlights < ActiveRecord::Migration[5.2]
  def change
    add_column :flights, :flight_code, :string
  end
end
