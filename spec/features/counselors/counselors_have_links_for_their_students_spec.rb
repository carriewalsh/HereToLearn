require 'rails_helper'

RSpec.describe "as a counselor" do
  context "on my dashboard" do
    it "has links to a counselor show for every student" do
      teacher = create(:teacher)
      counselor = create(:teacher, role: 'counselor')
      student1 = create(:student)
      student2 = create(:student)
      student3 = create(:student)

      classs = create(:course)
      counseling = create(:course)

      StudentCourse.create(course: classs, student: student1)
      StudentCourse.create(course: counseling, student: student2)
      StudentCourse.create(course: counseling, student: student3)
      TeacherCourse.create(course: classs, teacher: teacher)
      TeacherCourse.create(course: counseling, teacher: counselor)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(counselor)

      visit counselor_dashboard_path

      expect(page.all('.student').count).to eq(2)
      expect(page).to_not have_link(student1.name)
      click_link "#{student2.name}"

      expect(current_path).to eq(counselor_student_path(student2))
    end
  end
end
