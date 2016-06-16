class ChangeEnabledOptionForShift < ActiveRecord::Migration[5.0]
  def change
    change_column :shifts, :enabled, :boolean, default:false
  end
end
