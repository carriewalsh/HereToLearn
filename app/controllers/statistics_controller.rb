class StatisticsController < ApplicationController
  def index
    course = Course.find(params[:course_id])
    render locals: {
      facade: CourseFacade.new(current_user, course, nil)
    }
  end
end
