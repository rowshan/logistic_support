class AddTripRefToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_reference :addresses, :trip, foreign_key: true, type: :uuid
  end
end
