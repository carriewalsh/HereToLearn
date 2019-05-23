class TeachersController < ApplicationController
  def show
  end

  def edit
    if params[:update] && params[:update] == "confirm"
      @edit_fields = ["Old Password","New Password", "Confirm New Password"]
    elsif params[:update] && params[:update] == "reset"
      @edit_fields = ["New Password", "Confirm New Password"]
    else
      @edit_fields = ["first_name", "last_name", "email"]
    end
  end

  def update
    @teacher = Teacher.find(current_user.id)
    if params[:teacher]["Old Password"]
      if confirm_params["Old Password"] == @teacher.password && confirm_params["New Password"] == confirm_params["Confirm New Password"]
        @teacher.update(confirm_params)
        flash[:success] = "Successfully Reset Password"
      else
        flash.now[:error] = "Passwords don't match"
        render :edit
      end
    elsif params[:teacher]["New Password"]
      if confirm_params["New Password"] == confirm_params["Confirm New Password"]
        @teacher.update(reset_params)
        flash[:success] = "Successfully Reset Password"
      else
        flash.now[:error] = "Passwords don't match"
        render :edit
      end
    else
      @teacher.update(general_params)
      flash[:success] = "Successfully Updated Account Information"
    end
    redirect_to account_path
  end

  private

  def general_params
    params.require(:teacher).permit(:first_name,:last_name, :email)
  end

  def reset_params
    params.require(:teacher).permit("New Password", "Confirm New Password")
  end

  def confirm_params
    params.require(:teacher).permit("Old Password","New Password", "Confirm New Password")
  end
  # probably need various strong params for different update types
end
