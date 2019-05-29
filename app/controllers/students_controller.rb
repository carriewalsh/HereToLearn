class StudentsController < ApplicationController
  def show
    render locals: {
      facade: StudentFacade.new(params[:id], params[:course_id])
    }
  end


end
