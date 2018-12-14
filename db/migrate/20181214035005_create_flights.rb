class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.datetime :start
      t.datetime :end
      t.integer :origin_id
      t.integer :destination_id

      t.timestamps
    end
  end
end
