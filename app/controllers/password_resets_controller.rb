class PasswordResetsController < ApplicationController
  before_action :require_teacher! || :require_counselor!
  def edit

  end

  def update
    teacher = Teacher.find(current_user.id)
    if teacher.authenticate(reset_params["Old Password"])
      if reset_params["New Password"] == reset_params["Confirm New Password"]
        teacher.update_attribute(:password, reset_params["New Password"])
        flash[:notice] = "Successfully Reset Password"
        redirect_to account_path
      else
        flash[:error] = "New Passwords Do Not Match"
        render :edit
      end
    else
      flash[:error] = "Old Password Incorrect"
      render :edit
    end
  end

  private

    def reset_params
      params.require(:teacher).permit("Old Password", "New Password", "Confirm New Password")
    end
end
