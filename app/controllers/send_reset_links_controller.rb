class SendResetLinksController < ApplicationController
  before_action :get_teacher, only: [:edit, :update]
  before_action :valid_teacher, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new

  end

  def create
    @teacher = Teacher.find_by(email: reset_params[:email])
    if @teacher
      @teacher.create_reset_digest
      @teacher.send_password_reset_email
      flash[:notice] = "Email has been sent with password reset instructions"
      redirect_to login_path
    else
      flash[:danger] = "Email address not found"
      render :new
    end
  end

  def edit
  end

  def update
    if @teacher.update_attributes(teacher_params)
      @teacher.update_attribute(:reset_digest,nil)
      flash[:success] = "Successfully reset password."
      redirect_to login_path
    else
    end
  end

  private

    def reset_params
      params.require(:send_reset_link).permit(:email)
    end

    def teacher_params
      params.require(:teacher).permit(:password, :password_confirmation)
    end

    def get_teacher
      @teacher = Teacher.find_by(email: params[:email])
    end

    def valid_teacher
      unless (@teacher && @teacher.authenitcated?(:reset, params[:id]))
        redirect_to welcome_path
      end
    end

    def check_expiration
      if @teacher.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to send_password_reset_email_path
      end
    end
end
