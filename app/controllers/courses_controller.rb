class CoursesController < ApplicationController
  before_action :require_teacher!
  def index
    render locals: {
      facade: CoursesFacade.new(current_user)
    }
  end

  def show
    if params[:group_count]
      render locals: {
        facade: CourseFacade.new(current_user, course, params[:group_count])
      }
    else
    render locals: {
      facade: CourseFacade.new(current_user, course, nil)
    }
    end
  end

  private

    def course
      current_user.courses.find(params[:id])
    end
end
