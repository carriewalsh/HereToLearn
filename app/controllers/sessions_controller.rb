class SessionsController < ApplicationController
  def create
    teacher = Teacher.find_by(email: session_params[:email])
    if teacher && teacher.authenticate(session_params[:password])
      cookies.signed[:user_id] = teacher.id
      flash[:success] = "Successfully logged in"
      if teacher.role == 'teacher'
        redirect_to dashboard_path
      elsif teacher.role == 'counselor'
        redirect_to counselor_dashboard_path
      end
    else
      flash[:error] = "Sorry, wrong email/password combination"
      render :new
    end
  end

  def destroy
    cookies.signed[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to welcome_path
  end



  private

    def session_params
      params.require(:session).permit(:email,:password)
    end
end
