class Student::ResponseController < ApplicationController
  def create
    # Submit to API with post
    # post_responses
    attendance_record = find_attendance
    attendance_record.attendance = attendance_status if attendance_status
    attendance_record.save

    ActionCable.server.broadcast 'attendance_channel',
                                  student_id: session[:student_id],
                                  attendance: 'present',
                                  course_id: session[:course_id]


    flash[:info] = "Thank You!"
    redirect_to student_completed_survey_path
  end

  def show

  end

  private

  def attendance_status
    course = Course.find(session[:course_id])
    return nil if now.strftime("%H%M%S") > course.end_time.strftime("%H%M%S")
    return 'present' if now < course.start_time + 5.minutes
    'tardy'
  end

  def now
    DateTime.now
  end

  def find_attendance
    time_range = (now.beginning_of_day..now)
    Attendance.find_by(student_id: session[:student_id],
                       course_id: session[:course_id],
                       created_at: time_range)
  end

  def post_responses(question_ids, domain = 'https://aqueous-caverns-33840.herokuapp.com', endpoint = '/response')
    question_ids.each do |question_id|
      Faraday.post domain + endpoint, params: params_for_post(question_id)
    end

    Faraday.post domain + endpoint, params: headers_for_post
  end

  def params_for_post(question_id)
    {
      data:
        { student_id: session[:student_id],
          course_id: session[:course_id],
          answer_type: 'id',
          text_answer: nil,
          question_id: question_id,
          choice_id: params[:question][question_id]}
    }
  end

  def responses
    params.require(:question).permit(question_ids).to_hash
  end

  def question_ids
    session[:question_ids].map{ |i| i.to_s}
  end
end
