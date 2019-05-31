require "rails_helper"

describe "statistics index page" do
  describe "as a logged-in Teacher" do
    before :each do
      @teacher = create(:teacher, role: 2)
      @course = create(:course)
      create_list(:student, 4)
      @teacher.courses << Course.first
      Student.first.courses << @course
      Student.second.courses << @course
      Student.third.courses << @course
      Student.fourth.courses << @course
      att1 = Student.first.attendances.create(attendance: "absent",course_id: @course.id, created_at: DateTime.now.midnight)
      att2 = Student.second.attendances.create(attendance: "present",course_id: @course.id, created_at: DateTime.now.midnight)
      att3 = Student.third.attendances.create(attendance: "absent",course_id: @course.id, created_at: DateTime.now.midnight)
      att4 = Student.fourth.attendances.create(attendance: "present",course_id: @course.id, created_at: DateTime.now.midnight)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@teacher)
      visit course_path(Course.first.id)
    end

    it "shows bar charts about each individual student" do
      find(".navbar", text: 'Statistics').click
      click_on @course.name

      expect(current_path).to eq(statistics_path)
      expect(page).to have_content('Statistics')
    end
  end
end
