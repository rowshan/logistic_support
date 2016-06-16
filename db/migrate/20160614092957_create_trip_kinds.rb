class CreateTripKinds < ActiveRecord::Migration[5.0]
  def change
    create_table :trip_kinds,id: :uuid do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
