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

    it "should have a strategies section witl all strategies for that student" do
      teacher2 = create(:teacher)
      strat1 = @teacher.strategies.create(student_id: @student.id, strategy: "When Seattle Public Schools announced that it would reorganize school start times across the")
      strat2 = @teacher.strategies.create(student_id: @student.id, strategy: "district for the fall of 2016, the massive undertaking took more than a year to deploy.")
      strat3 = teacher2.strategies.create(student_id: @student.id, strategy: "Elementary schools started earlier, while most middle and all of the district's 18 high")
      visit student_path(@student, {course_id: @course.id})
      expect(page).to have_content("Student Strategies")
        expect(page).to have_css(".strategy",count: 3)
        expect(page).to have_content("By Me:", count: 2)
        expect(page).to have_content("By #{teacher2.first_name} #{teacher2.last_name}:", count: 1)
    end

    it "allows me to add a new strategy with a popup feature" do
      click_on "Add Strategy"
      fill_in "text", with: "He's just a super kid."
      click_on "Save Strategy"
      expect(current_path).to eq(@student, {course_id: @course.id})
      expect(page).to have_content("Successfully Added Strategy")
      expect(page).to have_content("He's just a super kid.")
    end

    it "allows me to delete MY strategies" do
      teacher2 = create(:teacher)
      strat1 = @teacher.strategies.create(student_id: @student.id, strategy: "When Seattle Public Schools announced that it would reorganize school start times across the")
      strat2 = teacher2.strategies.create(student_id: @student.id, strategy: "district for the fall of 2016, the massive undertaking took more than a year to deploy.")
      click_on "Delete Strategy"
      click_on "Yes"
      expect(current_path).to eq(@student, {course_id: @course.id})
      expect(page).to have_content("Successfully Deleted Strategy")
      expect(page).to_not have_content("#{strat1.strategy}")
      expect(page).to_not have_button("Delete Strategy")

      expect(Student.first.strategies.count).to eq(2)
      expect(Student.first.strategies.first.status).to eq("deactivated")
    end
  end
end
