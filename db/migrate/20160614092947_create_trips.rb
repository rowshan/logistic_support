class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips,id: :uuid do |t|
      t.uuid :trip_kind_id
      t.uuid :order_id
      t.date :date
      t.uuid :time_window_id
      t.uuid :address_id

      t.timestamps
    end
  end
end
