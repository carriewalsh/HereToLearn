class ChangeStartAndEndTimesForCoursesToStrings < ActiveRecord::Migration[5.2]
  def change
    change_column :courses, :start_time, :string
    change_column :courses, :end_time, :string
  end
end
