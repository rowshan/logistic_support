class RemoveTripIdFromAddresses < ActiveRecord::Migration[5.0]
  def change
    remove_column :addresses,:trip_id, :uuid
  end
end
