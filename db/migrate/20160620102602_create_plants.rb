class CreatePlants < ActiveRecord::Migration[5.0]
  def change
    create_table :plants,id: :uuid do |t|
      t.string :company
      t.text :email
      t.text :phone_no
      t.text :address
      t.uuid :tenant_id

      t.timestamps
    end
  end
end
