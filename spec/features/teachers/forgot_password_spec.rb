require "rails_helper"

describe "As a forgetful teacher, who forgot their password" do
  describe "when I reach the welcome page" do
    it "allows me to send an email to reset my password" do
      @teacher = create(:teacher) #, reset_token: "asdf", reset_sent_at: DateTime.now)
      visit welcome_path
      click_link "Forgot Password?"
      expect(current_path).to eq(send_reset_link_path)

      fill_in 'Email', with: @teacher.email
      click_button "SEND PASSWORD RESET EMAIL"
      expect(current_path).to eq(login_path)

      visit edit_send_reset_link_path
      fill_in "email[]"
    end

    it "does not allow me to reset my password with the wrong token" do

    end

    it "does not allow me to reset my password if token expired" do

    end
  end
end
