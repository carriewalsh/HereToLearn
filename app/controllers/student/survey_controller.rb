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

  def show
    facade = QuestionFacade.new([1,2]) # This should be changed as survey creation changes
    session[:question_ids] = [1,2]
    render locals: { facade: facade }
  end


end
