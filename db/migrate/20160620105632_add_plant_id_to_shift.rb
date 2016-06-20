class AddPlantIdToShift < ActiveRecord::Migration[5.0]
  def change
    add_column :shifts, :plant_id, :uuid
  end
end
