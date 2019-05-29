class ApplicationController < ActionController::Base

  helper_method :current_user, :current_counselor?, :date


  def current_user
    @current_user ||= Teacher.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  def current_counselor?
    !current_user.courses.empty?
  end

  def date
    wday = Date.today.strftime('%a')
    if wday == 'Sat' || wday == 'Sun'
      message = ' No Attendance Taken Today'
    else
      message = ''
    end
    "Today: #{Date.today.strftime('%a, %e %b, %Y')}#{message}"
  end
end
