class CreateTimeWindows < ActiveRecord::Migration[5.0]
  def change
    create_table :time_windows,id: :uuid do |t|
      t.string :label
      t.time :start_time
      t.time :end_time
      t.uuid :tenant_id

      t.timestamps
    end
  end
end
