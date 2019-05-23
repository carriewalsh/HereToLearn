class Student::SurveyController < ApplicationController
  def new
    google_id = request.env["omniauth.auth"][:uid]

    student = Student.find_by(google_id: google_id.to_s)
    if student
      flash[:info] = "Successfully Logged-In"
      redirect_to student_class_code_path
    else
      flash[:info] = "You are not registered in our system, please contact your teacher"
      redirect_to student_unregistered_path
    end
  end

  def create
    course_from_code = Code.find_by(code:params[:code])
    student = Student.find(session[:student_id])

    if course_from_code && student.courses.include?(course_from_code)
      session[:course_id] = course_from_code.course_id
      redirect student_survey_path
    else
      flash.now[:error] = "Invalid Code"
    end

  end
end
