class CreateDrivers < ActiveRecord::Migration[5.0]
  def change
    create_table :drivers,id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_no
      t.uuid :plant_id
      t.boolean :enabled, default:true

      t.timestamps
    end
  end
end
