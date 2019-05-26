class Student < ApplicationRecord
  validates_presence_of :first_name, :last_name, :google_id, :student_id
  validates_uniqueness_of :student_id

  has_many :student_courses
  has_many :courses, through: :student_courses
  has_many :attendances

  def todays_attendance
    today = attendances.where("created_at >= ?", Date.today)
    today.first ? today.first.attendance : "No Attendance Today"
  end

  def percent_present(course)
    100.0 - percent_absent(course)
  end

  def percent_absent(course)
    course_attendance = attendances.where(course_id: course.id)
    total_days = course_attendance.count
    (total_absences(course) * 100.0 / total_days).round(1)
  end

  def total_absences(course)
    course_attendance = attendances.where(course_id: course.id)
    options = ["absent", "absent_with_response"]
    course_attendance.where(attendance: options, course_id: course.id).count
  end

  def self.random_groups(count)
    shuffled = select("students.first_name || ' ' || students.last_name AS name").shuffle
    groups = []
    remaining = shuffled.count % count
    if remaining == 0
      (shuffled.count / count).times { groups << shuffled.slice!(0,count) }
    else
      groups << shuffled.slice!(0,remaining)
      ((shuffled.count / count) - 1).times { groups << shuffled.slice!(0,count) }
    end
    groups
  end

  def self.present_students
    students = Student.all
    students.find_all do |student|
      student.todays_attendance.include?("present") || student.todays_attendance == "tardy"
    end
  end
end
