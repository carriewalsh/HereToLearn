class Student < ApplicationRecord
  validates_presence_of :first_name, :last_name, :google_id, :student_id
  validates_uniqueness_of :student_id

  has_many :student_courses
  has_many :courses, through: :student_courses
  has_many :attendances
  has_many :strategies

  def todays_attendance(course_id = nil)
    today = attendances.where("created_at >= ?", Time.current - 24.hours)
    if course_id
      attendance = today.find_by(course_id: course_id)
      unless attendance.attendance
        return "nil"
      else
        return attendance.attendance
      end
    else
      today.first ? today.first.attendance : "No Attendance Today"
    end
  end

  def percent_present(course = nil)
    100.0 - percent_absent(course)
  end

  def percent_absent(course = nil)
    total_days = course_attendance(course).count
    (total_absences(course) * 100.0 / total_days).round(1)
  end

  def total_absences(course = nil)
    options = ["absent", "absent_with_response"]
    course_attendance(course).where(attendance: options).count
  end

  def course_attendance(course)
    return attendances.where(course: course) if course
    attendances
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
