class ChangeStartAndEndTimeToBeTimeOnlyInCourses < ActiveRecord::Migration[5.2]
  def change
    change_column :courses, :start_time, :time
    change_column :courses, :end_time, :time
  end
end
