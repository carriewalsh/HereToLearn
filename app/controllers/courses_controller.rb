class CoursesController < ApplicationController
  # should probably have a before action here for safety
  def index
    render locals: {
      facade: CoursesFacade.new(current_user)
    }
  end

  def show
    binding.pry
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
