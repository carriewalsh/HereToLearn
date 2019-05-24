require "rails_helper"

describe "As a visitor or user" do
  describe "when I visit the welcome page" do
    before :each do
      visit welcome_path
    end

    it "shows the name of the website" do
      expect(page).to have_content("HereToLearn")
    end

    it "shows the nav-bar without buttons" do
      within "nav" do
        expect(page).to_not have_link("Dashboard")
        expect(page).to_not have_link("My Account")
        expect(page).to_not have_link("Log Out")
      end
    end

    it "shows a footer with the about link" do
      within "footer" do
        expect(page).to have_link("About Site")
      end
    end

    it "has a place for me to log in" do
      within ".dynamic-container" do
        fill_in "session[email]", with: "test"
        fill_in "session[password]", with: "test"
        expect(page).to have_link("Forgot Password?")
        expect(page).to have_button("LOG IN")
        # click_button("LOG IN")
        # expect(current_path).to eq(dashboard_path)
      end
    end
  end
end
