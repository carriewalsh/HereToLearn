require "rails_helper"

describe "As a logged-in Teacher" do
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

  describe "When I visit a courses's show page" do
    it "shows me the class roster with today's attendance information" do
      expect(page).to have_content(@course.name)
      expect(page).to have_css('.student-card', count: 4)
      expect(page).to have_content("#{Student.first.first_name} #{Student.first.last_name}")
    end

    it "has a field and button that allows me to group randomly" do
      expect(page).to have_content "Grouping"
      expect(page).to have_content "Randomly:"
      fill_in "random-grouping", with: 2
      click_button "ALL STUDENTS"
    end
  end
end
