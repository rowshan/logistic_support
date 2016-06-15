class RemoveTimeFieldsFromTimeWindows < ActiveRecord::Migration[5.0]
  def change
    remove_column :time_windows, :start_time
    remove_column :time_windows, :end_time
  end
end
