require "rails_helper"

describe "statistics index page" do
  describe "as a logged-in Teacher" do
    before :each do
      @teacher = create(:teacher)
      @course = create(:course)
      create_list(:student, 4)
      @teacher.courses << Course.first
      Student.first.courses << @course
      Student.second.courses << @course
      Student.third.courses << @course
      Student.fourth.courses << @course

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@teacher)
      visit course_path(Course.first.id)
    end

    it "shows bar charts about each individual student" do
      click_on 'Statistics'

      expect(current_path).to eq(statistics_path)
      save_and_open_page
      expect(page).to have_content('Statistics')
    end
  end
end
