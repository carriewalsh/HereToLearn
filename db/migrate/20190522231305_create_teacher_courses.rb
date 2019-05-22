class CreateTeacherCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :teacher_courses do |t|
      t.references :teacher, foreign_key: true
      t.references :course, foreign_key: true
    end
  end
end
