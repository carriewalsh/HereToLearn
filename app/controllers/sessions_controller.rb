class SessionsController < ApplicationController
  def create
    teacher = Teacher.find_by(email: session_params[:email])
    if teacher && teacher.authenticate(session_params[:password])
      session[:user_id] = teacher.id
      flash[:success] = "Successfully logged in"
      redirect_to dashboard_path
    else
      flash[:error].now = "Sorry, bad wrong email/password combination"
    end
  end



  private

    def session_params
      params.require(:session).permit(:email,:password)
    end
end
