require "rails_helper"

describe "As a logged-in Teacher" do
  describe "when I visit a student's show page" do
    before :each do
      @course = create(:course)
      @course2 = create(:course)
      @teacher = create(:teacher)
      @teacher.courses << Course.first
      @student = create(:student)
      @student.courses << Course.first
      @student.courses << Course.last

      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "absent")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "absent")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course2.id, created_at: "2019-05-26 02:00:00", attendance: "absent")


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@teacher)
      visit student_path(@student, {course_id: @course.id})
    end

    it "should have student name and id" do
      expect(page).to have_content(@student.first_name)
      expect(page).to have_content(@student.last_name)
      expect(page).to have_content(@student.student_id)
    end

    it "should have the student's schedule" do
      expect(page).to have_content(@course.name)
      expect(page).to have_content(@course2.name)
    end

    it "should have a statistics section with attendance data" do
      within first ".statistics" do
        expect(page).to have_content("Attendance Statistics")
        expect(page).to have_content("Present: 80.0%")
        expect(page).to have_content("Absent: 20.0%")
        expect(page).to have_content("Total Absences: 2 days")
      end
    end

    xit "should have a calendar that shows this months attendance" do

    end

    xit "should have a graph that shows percentage attendance over time" do

    end
  end
end
