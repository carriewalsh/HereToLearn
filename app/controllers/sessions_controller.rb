class SessionsController < ApplicationController
  def create
    teacher = Teacher.find_by(email: params[:email])
    if teacher && teacher.authenticate(params[:password])
      session[:user_id] = teacher.id
      flash[:success] = "Successfully logged in"
      redirect_to dashboard_path
    end
  end
end
