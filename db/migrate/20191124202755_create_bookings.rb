class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :adventure_id
      t.string :adventure_title
      t.integer :ticket_quantity
      t.datetime :adventure_date
      t.decimal :cost
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
