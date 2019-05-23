class TeacherCourse < ApplicationRecord
  belongs_to :course
  belongs_to :teacher
end
