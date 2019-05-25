class Student < ApplicationRecord
  validates_presence_of :first_name, :last_name, :google_id, :student_id
  validates_uniqueness_of :student_id

  has_many :student_courses
  has_many :courses, through: :student_courses
  has_many :attendances

  def todays_attendance
    attendances.where("created_at >= ?", Date.today).first.attendance
  end
end
