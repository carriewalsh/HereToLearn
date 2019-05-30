class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :course

  enum attendance: [:absent, :present, :tardy, :present_no_response, :absent_with_response]

  def attendance_percent_this_date
    days = Attendance.where("created_at < ?", self.created_at + 1.day)
    total = days.count
    present = days.where(attendance: ["present", "present_no_response"]).count
    (100.0 * present / total).round(1)
  end
end
