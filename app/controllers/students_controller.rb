class StudentsController < ApplicationController
  before_action :require_teacher!
  def show
    render locals: {
      facade: StudentFacade.new(params[:id], params[:course_id])
    }
  end
end
