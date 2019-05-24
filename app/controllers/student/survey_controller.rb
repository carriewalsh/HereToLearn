class Student::SurveyController < ApplicationController
  def new
    google_id = request.env["omniauth.auth"][:uid]

    student = Student.find_by(google_id: google_id.to_s)
    if student
      session[:student_id] = student.id
      flash[:info] = "Successfully Logged-In"
      redirect_to student_class_code_path
    else
      flash[:info] = "You are not registered in our system, please contact your teacher"
      redirect_to student_unregistered_path
    end
  end

  def create
    course = course_from_code(params[:code])
    student = Student.find(session[:student_id])
    # binding.pry

    if course && student.courses.include?(course)
      session[:course_id] = course.id
      redirect_to student_survey_path
    else
      flash[:error] = "Invalid Code"
      redirect_to student_class_code_path
    end

  end

  def show
    facade = QuestionFacade.new([1,2]) # This should be changed as survey creation changes
    render locals: { facade: facade }
  end

  private

  def course_from_code(code)
    info = Code.find_by(code:code)
    if info
      return Course.find(info.course_id)
    else
      return nil
    end
  end
end
