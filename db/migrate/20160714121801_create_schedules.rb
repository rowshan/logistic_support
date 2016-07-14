class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules,id: :uuid do |t|
      t.date :date
      t.uuid :shift_id
      t.uuid :driver_id

      t.timestamps
    end
  end
end
