require "rails_helper"

describe Student, type: :model do
  describe "validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :google_id }
    it { should validate_presence_of :student_id }
    it { should validate_uniqueness_of :student_id }
  end

  describe "relationships" do
    it { should have_many :student_courses }
    it { should have_many :courses }
    it { should have_many :attendances }
  end

  describe "instance methods" do
    describe ".todays_attendance" do
      it "shows the value of TODAY's attendance if there was class" do
        today = DateTime.now.beginning_of_day
        yesterday = today-1

        student = create(:student)
        course = student.courses.create(name: "PE", period: "1", start_time: "2019-05-21 8:00:00", end_time: "2019-05-21 9:00:00")

        yesterday_att = student.attendances.create(course_id: course.id, created_at: yesterday, attendance: :absent)
        today_att = student.attendances.create(course_id: course.id, created_at: today, attendance: :present)
        expect(student.todays_attendance).to eq("present")
      end

      it "returns nil if TODAY's class hasn't started yet" do
        today = DateTime.now.beginning_of_day
        student = create(:student)
        course = student.courses.create(name: "PE", period: "1", start_time: "2019-05-21 8:00:00", end_time: "2019-05-21 9:00:00")
        today_att = student.attendances.create(course_id: course.id, created_at: today)
        expect(student.todays_attendance).to be(nil)
      end

      it "shows a response if there was no class today" do
        student = create(:student)
        response = "No Attendance Today"
        expect(student.todays_attendance).to eq(response)
      end
    end
  end

  describe "class methods" do
    describe ".random_groups()" do
      it "gives random groups based on an input number" do
        @teacher = create(:teacher)
        @course = create(:course)
        create_list(:student, 6)
        @teacher.courses << Course.first
        Student.first.courses << @course
        Student.second.courses << @course
        Student.third.courses << @course
        Student.fourth.courses << @course
        Student.all[-2].courses << @course
        Student.last.courses << @course

        result = Student.random_groups(2)
        expect(result).to be_an(Array)
        expect(result.count).to eq(3)
        expect(result.first).to be_an(Array)
        expect(result.first.count).to eq(2)
        expect(result.flatten.uniq.count).to eq(6)
      end
    end

    describe ".present students" do
      it "returns only students who are present or tardy" do
        create_list(:student, 5)
        Student.first.attendances.create(course_id: 3, created_at: DateTime.now.midnight , attendance: "present")
        Student.second.attendances.create(course_id: 3, created_at: DateTime.now.midnight , attendance: "present_no_response")
        Student.third.attendances.create(course_id: 3, created_at: DateTime.now.midnight , attendance: "tardy")
        Student.fourth.attendances.create(course_id: 3, created_at: DateTime.now.midnight , attendance: "absent")
        Student.fifth.attendances.create(course_id: 3, created_at: DateTime.now.midnight , attendance: "absent_with_response")

        expect(Student.present_students.includes?(Student.fourth)).to be false
        expect(Student.present_students.includes?(Student.fifth)).to be false
        expect(Student.present_students.count).to eq(3)
      end
    end
  end
end
