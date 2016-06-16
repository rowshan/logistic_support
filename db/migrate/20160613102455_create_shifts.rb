class CreateShifts < ActiveRecord::Migration[5.0]
  def change
    create_table :shifts,id: :uuid do |t|
      t.string :name
      t.time :start_time
      t.time :end_time
      t.time :second_time
      t.boolean :enabled

      t.timestamps
    end
  end
end
