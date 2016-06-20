class RemoveAddressIdFromTrip < ActiveRecord::Migration[5.0]
  def change
    remove_column :trips,:address_id, :uuid
  end
end
