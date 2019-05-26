class StudentsController < ApplicationController
  def show
    render locals: {
      facade: StudentsFacade.new(params[:id])
    }
  end
end
