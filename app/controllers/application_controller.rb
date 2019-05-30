class ApplicationController < ActionController::Base

  helper_method :current_user, :current_counselor?, :date


  def current_user
    @current_user ||= Teacher.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  def current_counselor?
    current_user.counselor?
  end

  def four_oh_four
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  def require_teacher!
    if current_user.nil?
      four_oh_four
    else
      four_oh_four unless current_user.teacher?
    end
  end

  def require_counselor!
    if current_user.nil?
      four_oh_four
    else
      four_oh_four unless current_user.counselor?
    end
  end

  # def my_course!(course)
  #   if current_user.nil?
  #     four_oh_four
  #   else
  #     four_oh_four unless current_user.courses.
  #   end
  # end

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
