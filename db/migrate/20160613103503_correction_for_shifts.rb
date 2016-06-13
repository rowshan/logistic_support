class CorrectionForShifts < ActiveRecord::Migration[5.0]
  def change
    rename_column :shifts, :second_time, :send_time
  end
end
