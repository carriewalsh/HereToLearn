class Api::V1::MachineLearningController < ApplicationController

  def show
    render json: ResultsSerializer.new(Student.get_student(params[:student_id]))
  end

end
