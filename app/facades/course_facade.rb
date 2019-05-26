class CourseFacade
  attr_reader :current_user, :course

  def initialize(current_user, course)
    @current_user = current_user
    @course = course
  end

  def students
    current_user.courses.find(course.id).students
  end
end
