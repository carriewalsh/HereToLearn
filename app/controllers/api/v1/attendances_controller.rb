class Api::V1::AttendancesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def update
    # binding.pry
    attendance = Attendance.find_by(course_id: params[:course_id], student_id: params[:student_id], created_at: (Time.current - 24.hours..Time.current))
    # binding.pry
    attendance.update_attribute(:attendance, params[:attendance])
  end
end
