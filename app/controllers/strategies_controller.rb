class StrategiesController < ApplicationController
  def create
    strategy = Strategy.new(strategy_params)
    if strategy.save
      redirect_to student_path(params[:strategy][:student_id], course_id: params[:strategy][:course_id])
    end
  end

  def update

  end

  def deactivate
    strategy = Strategy.find(params[:id])
    strategy.update(active: false)
    redirect_to student_path(strategy.student_id, course_id: params[:course_id])
  end

  private

    def strategy_params
      params.require(:strategy).permit(:teacher_id, :student_id, :strategy)
    end
end
