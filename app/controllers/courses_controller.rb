class CoursesController < ApplicationController
  def index
    render locals: {
      facade: CoursesFacade.new(current_user)
    }
  end
end
