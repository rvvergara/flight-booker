class RemovePassengerCountFromBookings < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookings, :passenger_count
  end
end
