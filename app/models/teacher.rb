class Teacher < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  has_secure_password allow_blank: true

  has_many :teacher_courses
  has_many :courses, through: :teacher_courses
end
