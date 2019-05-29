class StrategiesController < ApplicationController
  def create
    strategy = Strategy.new(strategy_params)
    if strategy.save
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
    redirect_to student_path(strategy.student_id, course_id: params[:course_id], anchor: 'strategies')
  end

  private

    def strategy_params
      params.require(:strategy).permit(:teacher_id, :student_id, :strategy)
    end

    def update_params
      params.require(:strategy).permit(:strategy)
    end
end
