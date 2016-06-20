class AddTripIdToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :trip_id, :uuid
  end
end
