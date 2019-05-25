class ApplicationController < ActionController::Base

  helper_method :current_user, :current_counselor?


  def current_user
    @current_user ||= Teacher.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  def current_counselor?
    !current_user.courses.empty?
  end
end
