class CreateShiftdates < ActiveRecord::Migration
  def change
    create_table :shiftdates do |t|
      t.date :date
      t.integer :user_id

      t.timestamps
    end
    add_index :shiftdates, :date, :unique => true
    add_index :shiftdates, [:user_id, :created_at]
  end
end
