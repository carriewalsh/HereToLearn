class Student::ResponseController < ApplicationController
  def create
    # Submit to API with post
    # post_responses
    # binding.pry
    flash[:info] = "Thank You!"
    redirect_to student_completed_survey_path
  end

  def show

  end

  private

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
