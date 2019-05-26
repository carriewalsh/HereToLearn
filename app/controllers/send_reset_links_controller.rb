class SendResetLinksController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expieration, only: [:edit, :update]

  def new

  end

  def create
    @teacher = Teacher.find_by(email: reset_params[:email])
    if @teacher
      @teacher.create_reset_digest
      binding.pry
      @teacher.send_password_reset_email
      flash[:notice] = "Email has been sent with password reset instructions"
      redirect_to login_path
    else
      flash[:notice] = "Email address not found"
      render :new
    end
  end

  def edit
    @teacher =
  end

  def update

  end

  private

    def reset_params
      params.require(:password_reset).permit(:email)
    end

    def get_user
      @teacher = Teacher.find_by(email: params[:email])
    end

    def valid_user
      unless (@user && @user.authenitcated?(:reset, params[:id]))
        redirect_to welcome_path
      end
    end
end
