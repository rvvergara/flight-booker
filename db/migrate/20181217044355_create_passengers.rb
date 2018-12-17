class CreatePassengers < ActiveRecord::Migration[5.2]
  def change
    create_table :passengers do |t|
      t.references :booking, foreign_key: true
      t.string :name
      t.string :email

      t.timestamps
    end
    add_index :passengers, :name
    add_index :passengers, :email
  end
end
