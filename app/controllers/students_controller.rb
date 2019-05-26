class StudentsController < ApplicationController
  def show
    render locals: {
      facade: StudentsFacade.new(params[:id], params[:course_id])
    }
  end
end
