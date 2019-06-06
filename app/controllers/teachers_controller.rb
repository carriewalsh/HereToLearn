class TeachersController < ApplicationController
  before_action :current_user

  def show
  end

  def edit
  end

  def update
    teacher = Teacher.find(current_user.id)
    if teacher.update(account_params)
      flash[:notice] = "Successfully Updated Account Information"
      redirect_to account_path
    else
      flash[:error] = "Invalid Changes"
      render :edit
    end
  end

  private

    def account_params
      params.require(:teacher).permit(:first_name,:last_name,:email)
    end
end
