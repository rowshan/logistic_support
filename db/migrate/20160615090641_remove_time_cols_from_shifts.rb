class RemoveTimeColsFromShifts < ActiveRecord::Migration[5.0]
  def change
    remove_column :shifts, :start_time, :string
    remove_column :shifts, :end_time, :string
    remove_column :shifts, :send_time, :string
  end
end
