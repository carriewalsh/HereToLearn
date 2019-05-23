require "rails_helper"

describe "As a logged-in teacher" do
  describe "when I visit my account page" do
    before :each do
      @teacher = create(:teacher)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@teacher)
      visit account_path
    end

    it "shows me my information" do
      within ".account-card" do
        expect(page).to have_content("#{@teacher.first_name} #{@teacher.last_name}")
        expect(page).to have_content("#{@teacher.email}")
      end
    end

    it "allows me to update my non-password information" do
      old_name = @teacher.last_name
      old_email = @teacher.email

      click_link "Edit Information"

      expect(page).to_not have_content("password")
      fill_in "Last name", with: "Nitro"
      fill_in "Email", with: "wnitro@example.com"
      click "Submit Changes"

      expect(page).to have_content("Successfully Updated Account Information")
      expect(page).to have_content("#{@teacher.first_name} #{@teacher.last_name}")
      expect(page).to_not have_content("#{@teacher.first_name} #{old_name}")
      expect(page).to have_content("#{@teacher.email}")
      expect(page).to_not have_content(old_email)
    end

    it "allows me to update my password" do
      old_password = @teacher.password

      click_link "Reset Password"

      fill_in "Old password", with: old_password
      fill_in "New password", with: "new_password"
      fill_in "Confirm new password", with: "new_password"
      click "Submit Changes"

      expect(page).to have_content("Successfully Reset Password")

      click_link "Log Out"

      fill_in "session[email]", with: @teacher.email
      fill_in "session[password]", with: @teacher.password
      click_on "Log In"

      expect(page).to have_content("Logged in as #{@teacher.first_name} #{@teacher.last_name}")
    end

    it "allows me to cancel an account update" do
      click_link "Edit Information"
      click_link "Cancel"

      expect(current_path).to eq(account_path)

      click_link "Reset Password"
      click_link "Cancel"

      expect(current_path).to eq(account_path)
    end
  end
end
