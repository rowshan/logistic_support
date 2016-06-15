class AddTimeFieldsToShifts < ActiveRecord::Migration[5.0]
  def change
    add_column :shifts, :start_time, :time
    add_column :shifts, :end_time, :time
    add_column :shifts, :send_time, :time
  end
end
