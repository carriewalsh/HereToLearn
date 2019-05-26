class CoursesController < ApplicationController
  # should probably have a before action here for safety
  def index
    render locals: {
      facade: CoursesFacade.new(current_user)
    }
  end

  def show
    render locals: {
      facade: CourseFacade.new(current_user, course)
    }
  end

  private

    def course
      current_user.courses.find(params[:id])
    end
end
