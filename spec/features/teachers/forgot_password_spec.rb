require "rails_helper"

describe "As a forgetful teacher, who forgot their password" do
  describe "when I reach the welcome page" do
    xit "allows me to send an email to reset my password" do
      @teacher = create(:teacher)
      visit welcome_path
      click_link "Forgot Password?"
      expect(current_path).to eq(send_reset_link_path)

      fill_in 'Email', with: @teacher.email
      click_button "SEND PASSWORD RESET EMAIL"
      expect(current_path).to eq(login_path)

      @teacher.update_attributes(reset_token: "asdf", reset_sent_at: DateTime.now)
      visit edit_send_reset_link_path(@teacher.reset_token, email: @teacher.email)
      expect(page).to have_content("HereToLearn Password Reset")
      expect(page).to have_css("#email", visible: false, text: "#{@teacher.email}")

      fill_in :password, with: "new_password"
      fill_in :password_confirmation, with: "whoops_password"
      click_button "RESET PASSWORD"
      expect(page).to have_content("Passwords must match")

      fill_in :password, with: "new_password"
      fill_in :password_confirmation, with: "new_password"
      click_button "RESET PASSWORD"
      expect(page).to have_content("Successfully reset password.")
      expect(current_path).to eq(login_path)
    end

    xit "does not allow me to reset my password with the wrong token" do
      @teacher = create(:teacher)
      visit welcome_path
      click_link "Forgot Password?"
      expect(current_path).to eq(send_reset_link_path)

      fill_in 'Email', with: @teacher.email
      #fails here until I set a host
      click_button "SEND PASSWORD RESET EMAIL"
      expect(current_path).to eq(login_path)

      @teacher.update_attributes(reset_token: "asdf", reset_sent_at: DateTime.now)
      visit edit_send_reset_link_path("not_token", email: @teacher.email)
      expect(page).to have_content("Invalid link") ###IS THIS RIGHT
      expect(current_path).to eq(welcome_path)

    end

    it "does not allow me to reset my password if token expired" do

    end

    it "does not allow password reset for an invalid email" do
      visit welcome_path
      click_link "Forgot Password?"
      expect(current_path).to eq(send_reset_link_path)

      fill_in 'Email', with: "asdf@asdf.com"
      click_button "SEND PASSWORD RESET EMAIL"
      expect(current_path).to eq(send_reset_link_path)
      expect(page).to have_content("Email address not found")
    end
  end
end
