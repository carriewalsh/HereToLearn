class CoursesFacade
  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def courses
    current_user.courses
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
