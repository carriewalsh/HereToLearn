class Attendance < ApplicationRecord
  belongs_to :student_id
  belongs_to :class_id
end
