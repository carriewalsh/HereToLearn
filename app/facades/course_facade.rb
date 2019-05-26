class CourseFacade
  attr_reader :current_user, :course

  def initialize(current_user, course)
    @current_user = current_user
    @course = course
  end

  def students
    current_user.courses.find(course.id).students
  end

  def date
    wday = Date.today.strftime('%a')
    if wday = 'Sat' || wday = 'Sun'
      message = ' No Attendance Taken Today'
    else
      message = ''
    end
    "Today: #{Date.today.strftime('%a, %e %b, %Y')}#{message}"
  end
end
