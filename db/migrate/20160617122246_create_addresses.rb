class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses,id: :uuid do |t|
      t.string :salutation
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :street
      t.string :house_no_main
      t.string :house_no_add
      t.string :other
      t.uuid :postal_code_id
      t.string :postal_code
      t.uuid :city_id
      t.string :city
      t.uuid :province_id
      t.string :province
      t.uuid :country_id
      t.string :country_code
      t.string :country


      t.timestamps
    end
  end
end
