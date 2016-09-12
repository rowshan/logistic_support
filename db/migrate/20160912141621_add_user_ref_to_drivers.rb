class AddUserRefToDrivers < ActiveRecord::Migration[5.0]
  def change
    add_column :drivers, :user_id, :uuid
  end
end
