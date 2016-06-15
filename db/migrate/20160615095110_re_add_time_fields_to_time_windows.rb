class ReAddTimeFieldsToTimeWindows < ActiveRecord::Migration[5.0]
  def change
    add_column :time_windows, :start_time, :time
    add_column :time_windows, :end_time, :time

  end
end
