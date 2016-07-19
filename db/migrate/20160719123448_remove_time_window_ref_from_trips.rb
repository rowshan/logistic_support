class RemoveTimeWindowRefFromTrips < ActiveRecord::Migration[5.0]
  def change
    remove_reference :trips, :time_window, foreign_key: false, type: :uuid
  end
end
