require "rails_helper"

describe "As a logged-in Teacher" do
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

  describe "When I visit a courses's show page" do
    it "shows me the class roster with today's attendance information" do
      expect(page).to have_content(@course.name)
      expect(page).to have_css('.student-card', count: 4)
      expect(page).to have_content("#{Student.first.first_name} #{Student.first.last_name}")
    end

    it "has a field and button that allows me to group randomly" do

    end
  end
end
