class AddColumnsToShifts < ActiveRecord::Migration[5.0]
  def change
    add_column :shifts, :availability, 'bit(8)'
  end
end
