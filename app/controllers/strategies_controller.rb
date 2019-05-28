class StrategiesController < ApplicationController
  def new

  end

  def edit

  end

  def update

  end

  def deactivate
    # binding.pry
    strategy = Strategy.find(params[:id])
    strategy.update(active: false)
    redirect_to student_path(strategy.student_id, course_id: params[:course_id])
  end
end
