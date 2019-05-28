class Student::ClassCodeController < ApplicationController
  def new
  end

  def create
    course = course_from_code(params[:code])
    student = Student.find(session[:student_id])
    binding.pry

    if course && student.courses.include?(course)
      session[:course_id] = course.id

      redirect_to student_survey_path
    else
      flash[:error] = "Invalid Code"
      redirect_to student_class_code_path
    end

  end

  private

  def course_from_code(code)
    info = Code.find_by(code:code)
    if info
      return Course.find(info.course_id)
    else
      return nil
    end
  end
end
