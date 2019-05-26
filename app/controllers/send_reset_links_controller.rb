class SendResetLinksController < ApplicationController
  def new

  end

  def create
    @user = Teacher.find_by(email: reset_params[:email])
    if @user
      binding.pry
      @user.create_reset_digest # Failing here
      @user.send_password_reset_email
      flash[:notice] = "Email has been sent with password reset instructions"
      redirect_to login_path
    else
      flash[:notice] = "Email address not found"
      render :new
    end
  end

  def edit

  end

  def update

  end

  private

    def reset_params
      params.require(:password_reset).permit(:email)
    end
end
