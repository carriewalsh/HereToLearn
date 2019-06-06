class Counselor::StudentsController < ApplicationController
  def show
  end

  def index
    render locals: { facade: CounselorFacade.new(current_user) }
  end
end
