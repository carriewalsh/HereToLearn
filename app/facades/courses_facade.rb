class CoursesFacade
  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def courses
    current_user.courses
  end

  def students(course_id)
    courses.find(course_id).students
  end
end
