class Student < ApplicationRecord
  validates_presence_of :first_name, :last_name, :token, :student_id
  validates_uniqueness_of :student_id

  has_many :student_courses
  has_many :courses, through: :student_courses
end
