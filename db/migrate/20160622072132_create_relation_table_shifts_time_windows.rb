class CreateRelationTableShiftsTimeWindows < ActiveRecord::Migration[5.0]
  def change
    create_table :shifts_time_windows,:id=> false do |t|
      t.uuid :shift_id,index: true
      t.uuid :time_window_id, index: true
    end
  end
end
