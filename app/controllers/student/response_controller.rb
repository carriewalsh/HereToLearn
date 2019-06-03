class Student::ResponseController < ApplicationController
  def create
    # Submit to API with post
    binding.pry
    if session[:student_id]
      post_responses

      attendance_record = find_attendance

      ActionCable.server.broadcast 'attendance_channel',
                                    student_id: session[:student_id],
                                    attendance: attendance_record.attendance,
                                    course_id: session[:course_id]

    elsif session[:student_name]
      student  = Student.create(
        first_name: "Guest",
        last_name: session[:student_name],
        id: (Student.count + 1),
        google_id: SecureRandom.hex(2),
        student_id: SecureRandom.hex(2)
      )
      session[:student_id] = student.id
      student.courses << Course.find(session[:course_id])
      attendance_record = find_attendance

      ActionCable.server.broadcast 'attendance_channel',
        student_id: session[:student_id], student_name: session[:student_name],
        attendance: attendance_record.attendance, course_id: session[:course_id]

      post_responses

    else
      redirect_to welcome_path
    end

    flash[:info] = "Thank You!"
    redirect_to student_completed_survey_path
  end

  def show

  end

  private

  def attendance_status
    course = Course.find(session[:course_id])

    tardy_time = Time.parse(course.start_time) + 5.minutes
    tardy_time_string = compareable_time(tardy_time)
    now_time_string = compareable_time(now)
    end_time_string = compareable_time(Time.parse(course.end_time))

    return nil if now_time_string > end_time_string
    return 'present' if now_time_string < tardy_time_string
    'tardy'
  end

  def compareable_time(time)
    time.strftime("%H%M")
  end

  def now
    Time.current.in_time_zone("America/Denver")
  end

  def find_attendance
    time_range = (now.beginning_of_day..now)
    attendance = Attendance.find_by(student_id: session[:student_id],
                       course_id: session[:course_id],
                       created_at: time_range)

    unless attendance
      attendance = Attendance.create(student_id: session[:student_id], course_id: session[:course_id])
    end
    attendance.attendance = attendance_status if attendance_status
    attendance.save

    attendance
  end
# 'https://aqueous-caverns-33840.herokuapp.com/api/v1/'
  def post_responses( domain = 'https://aqueous-caverns-33840.herokuapp.com/api/v1/', endpoint = 'responses')
    question_ids.each do |question_id|
      Faraday.post domain + endpoint, params_for_post(question_id)
    end
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

  def question_ids
    session[:question_ids].map{ |i| i.to_s}
  end
end
