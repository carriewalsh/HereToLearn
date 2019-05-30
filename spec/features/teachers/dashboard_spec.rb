require "rails_helper"

describe "As a logged-in teacher" do
  describe "when I visit my dashboard" do
    before :each do
      @teacher = create(:teacher)
      create_list(:course, 2)
      create_list(:student, 4)
      @teacher.courses << Course.first
      Student.first.courses << Course.first
      Student.second.courses << Course.first
      Student.third.courses << Course.second
      Student.fourth.courses << Course.second

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@teacher)
      visit dashboard_path
    end

    it "shows me all of my classes" do
      count = @teacher.courses.count
      expect(page).to have_css(".course-card", count: count)
    end

    it "shows me all of my students for each class" do
      count = @teacher.courses.first.students.count
      within first ".course-card" do
        expect(page).to have_css(".student-card", count: count)
      end
    end

    it 'can request a prediction' do
      WebMock.allow_net_connect!
      will= Student.create!(first_name: "William", last_name: "Peterson", student_id: "6", google_id: "107113987859408235003")
      @course = create(:course)

      visit student_path(will, course_id: @course.id)
      click_on "Predict Test Scores"
      # expect(page).to have_content("Predicted Score")
      # expect(page).to have_content("Sleep Information")
      # expect(page).to have_content("Breakfast Percentage")
    end

  end
end
