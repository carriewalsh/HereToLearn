class SendResetLinksController < ApplicationController
  def new

  end

  def create
    binding.pry
    @user = User.find_by(email: reset_params)
    if @user
      @user.create_reset_digest
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
