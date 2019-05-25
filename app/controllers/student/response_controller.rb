class Student::ResponseController < ApplicationController
  def create
    # Submit to API with post
    # post_responses

    attendance_record = find_attendance
    attendance_record.attendance = attendance_status if attendance_status
    attendance_record.save

    ActionCable.server.broadcast 'attendance_channel',
                                  student_id: session[:student_id],
                                  attendance: 'present'


    flash[:info] = "Thank You!"
    redirect_to student_completed_survey_path
  end

  def show

  end

  private

  def attendance_status
    course = Course.find(session[:course_id])
    return nil if now > course.end_time
    return 'present' if now < course.start_time + 5.minutes
    'tardy'
  end

  def now
    DateTime.now()
  end

  def find_attendance
    time_range = (now-1.hour..now)
    Attendance.find_by(student_id: session[:student_id],
                       course_id: session[:course_id],
                       created_at: time_range)
  end
  def post_responses
    domain = 'http://surveyapp.com'
    endpoint = '/response'

    Faraday.post domain + endpoint,  headers: headers_for_post
  end

  def headers_for_post
    {student_id: session[:student_id],
     course_id: session[:course_id],
     responses: responses}
  end

  def responses
    params.require(:question).permit(question_ids).to_hash
  end

  def question_ids
    session[:question_ids].map{ |i| i.to_s}
  end
end
