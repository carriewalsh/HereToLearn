class SurveyController < ApplicationController
  def new
    google_id = request.env["omniauth.auth"][:uid]

    student = Student.find_by(google_id: google_id.to_s)
    if student
      flash[:info] = "Successfully Logged-In"
      redirect_to class_code_path
    else
      flash[:info] = "You are not registered in our system, please contact your teacher"
      redirect_to unregistered_path
    end

  end
end
