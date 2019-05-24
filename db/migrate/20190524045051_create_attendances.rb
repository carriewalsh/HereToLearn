class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :student_id, foreign_key: true
      t.references :class_id, foreign_key: true
      t.integer :attendance

      t.timestamps
    end
  end
end
