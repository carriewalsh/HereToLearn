class Student::ResponseController < ApplicationController
  def create
    # Submit to API with post
    flash[:info] = "Thank You!"
    redirect_to student_completed_survey_path
  end

  def show

  end
end
