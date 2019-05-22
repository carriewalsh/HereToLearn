class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :period
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
