require "rails_helper"

describe "As a visitor or user" do
  describe "when I visit the about page" do
    it "shows a blurb about website" do
      visit welcome_path
      click_link "About Site"
      expect(current_path).to eq(about_path)
      expect(page).to have_content("Turing School of Software & Design")
    end

    it "shows a return to home page link" do
      visit about_path
      click_link("Back to Home")
      expect(current_path).to eq(welcome_path)
    end
  end
end
