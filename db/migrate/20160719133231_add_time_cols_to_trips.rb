class AddTimeColsToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :start_time, :time
    add_column :trips, :end_time, :time
  end
end
