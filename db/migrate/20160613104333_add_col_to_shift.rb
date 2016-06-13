class AddColToShift < ActiveRecord::Migration[5.0]
  def change
    add_column :shifts, :time_window_id, :uuid
  end
end
