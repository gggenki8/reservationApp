class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.date :check_in
      t.date :check_out
      t.integer :number_of_guests
      t.integer :total_price

      t.timestamps
    end
  end
end
