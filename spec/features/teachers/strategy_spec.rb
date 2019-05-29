require 'rails_helper'

RSpec.describe "as a teacher writing a strategy" do
  context "when i sumbit my strategy" do
    before :each do
      @student = create(:student)
      @teacher = create(:teacher, role: :teacher)
      @course = create(:course)
      StudentCourse.create(course: @course, student: @student)
      TeacherCourse.create(course: @course, teacher: @teacher)
    end

    it "gets graded positively", :vcr do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@teacher)
      visit student_path(@student, course_id: @course.id)

      fill_in "strategy[strategy]", with: "Blake can sometimes be jittery and needs assistance staying on tasks. It is helpful for him to have a short list of tasks and he can take a small break in between completion."
      click_on "SAVE STRATEGY"

      strategy = Strategy.last

      expect(strategy.flagged).to eq(false)
    end

    it "gets flagged", :vcr do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@teacher)
      visit student_path(@student, course_id: @course.id)

      fill_in "strategy[strategy]", with: "Blake is extremely jittery and annoys other students. He tends to be off task."
      click_on "SAVE STRATEGY"

      strategy = Strategy.last

      expect(strategy.flagged).to eq(true)
    end
  end
end
