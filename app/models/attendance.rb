class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :course

  enum attendance: [:absent, :present, :tardy, :present_no_response, :absent_with_response]

  def days_upto_this_date(course)
    days = Attendance.where("created_at < ?", DateTime.tomorrow).where(course_id: course.id).distinct.pluck(:created_at)
    days.map {|day| day.strftime("%e-%b")}
  end

  def percent_this_date(course)
    days = Attendance.where("created_at < ?", self.created_at + 1.day).where(course_id: course.id)
    total = days.count
    present = days.where(attendance: ["present", "present_no_response", "tardy"]).count
    (100.0 * present / total).round(1)
  end
end
