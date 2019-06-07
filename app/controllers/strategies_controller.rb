class StrategiesController < ApplicationController
  before_action :require_teacher! || :require_counselor!

  def create
    strategy = Strategy.new(strategy_params)
    service = GoogleService.new(strategy.strategy)
    rating = service.get_rating
    if strategy.save
      if rating <= -0.25
        strategy.update(flagged: true)
      end
      flash[:notice] = "Successfully Added Strategy."
      redirect_to student_path(params[:strategy][:student_id], course_id: params[:strategy][:course_id])
    end
  end

  def update
    strategy = Strategy.find(params[:id])
    if strategy.update(update_params)
      flash[:notice] = "Successfully Updated Strategy."
      redirect_to student_path(strategy.student_id, course_id: params[:strategy][:course_id], anchor: 'strategies')
    end
  end

  def deactivate
    strategy = Strategy.find(params[:id])
    strategy.update(active: false)
    flash[:notice] = "Successfully Deleted Strategy."
    if current_user.role == 'teacher'
      redirect_to student_path(strategy.student_id, course_id: params[:course_id], anchor: 'strategies')
    elsif current_user.role == 'counselor'
      redirect_to counselor_dashboard_path
    end
  end

  def approve
    strategy = Strategy.find(params[:id])
    strategy.update(flagged: false)
    redirect_to counselor_dashboard_path
  end

  private

    def strategy_params
      params.require(:strategy).permit(:teacher_id, :student_id, :strategy)
    end

    def update_params
      params.require(:strategy).permit(:strategy)
    end
end
