require "rails_helper"

describe "As a visitor or user" do
  describe "when I visit the welcome page" do
    before :each do
      visit welcome_path
    end

    it "shows the name of the website" do
      expect(page).to have_content("HereToLearn")
    end

    it "shows the nav-bar without 'log out'" do
      within "nav" do
        expect(page).to have_link("Dashboard")
        expect(page).to_not have_link("Log Out")
      end
    end

    it "has a place for me to log in" do
      within ".login-container" do
        fill_in "email", with: "test"
        fill_in "password", with: "test"
        expect(page).to have_button("Log In")
        expect(page).to have_link("Forgot Password?")
      end
    end
  end
end
