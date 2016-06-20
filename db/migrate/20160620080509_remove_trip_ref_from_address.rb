class RemoveTripRefFromAddress < ActiveRecord::Migration[5.0]
  def change
    remove_reference :addresses, :trip, foreign_key: true, type: :uuid
  end
end
