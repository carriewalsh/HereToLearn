class StrategiesController < ApplicationController
  def create
    binding.pry
  end

  def update

  end

  def deactivate
    strategy = Strategy.find(params[:id])
    strategy.update(active: false)
    redirect_to student_path(strategy.student_id, course_id: params[:course_id])
  end
end
