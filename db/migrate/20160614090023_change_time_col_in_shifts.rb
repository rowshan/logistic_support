class ChangeTimeColInShifts < ActiveRecord::Migration[5.0]
  def change
    change_column :shifts, :start_time, :string
    change_column :shifts, :end_time, :string
    change_column :shifts, :send_time, :string
  end
end
