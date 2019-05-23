class TeachersController < ApplicationController
  def show
  end

  def edit
    if params[:update] && params[:update] == "confirm"
      @edit_fields = ["Old Password","New Password", "Confirm New Password"]
    elsif params[:update] && params[:update] == "reset"
      @edit_fields = ["New Password", "Confirm New Password"]
    else
      @edit_fields = ["First Name", "Last Name", "Email"]
    end
  end


  # probably need various strong params for different update types
end
