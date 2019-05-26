require "rails_helper"

describe "As a forgetful teacher, who forgot their password" do
  describe "when I reach the welcome page" do
    it "allows me to send an email to reset my password" do
      @teacher = create(:teacher)
      visit welcome_path
      click_link "Forgot password?"
      expect(current_path).to eq(send_reset_link_path)

      fill_in 'Email', with: @teacher.email
      click_button "SEND PASSWORD RESET EMAIL"
      expect(current_path).to eq(login_path)
    end
  end
end
