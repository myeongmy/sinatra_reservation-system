class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :name
      t.string :password
      t.string :day
      t.string :time
      t.integer :host_id

      t.timestamps null: false
    end
  end
end
