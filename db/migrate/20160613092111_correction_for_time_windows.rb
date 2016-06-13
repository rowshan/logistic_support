class CorrectionForTimeWindows < ActiveRecord::Migration[5.0]
  def change
    change_column :time_windows, :start_time, :string
    change_column :time_windows, :end_time, :string
  end
end
