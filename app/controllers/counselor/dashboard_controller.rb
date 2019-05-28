#currently not in use, potential for the future
class Counselor::DashboardController < ApplicationController
  def index
    render locals: { facade: CounselorFacade.new(current_user) }
  end
end
