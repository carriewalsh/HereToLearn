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
    describe "attendance stats" do
      before :each do
        @course = create(:course)
        @course2 = create(:course)
        @teacher = create(:teacher)
        @teacher.courses << Course.first
        @student = create(:student)
        @student.courses << Course.first
        @student.courses << Course.last

        8.times { @student.attendances.create(course: @course, attendance: "present") }
        2.times { @student.attendances.create(course: @course, attendance: "absent") }

        6.times { @student.attendances.create(course: @course2, attendance: "present") }
        4.times { @student.attendances.create(course: @course2, attendance: "absent") }

      end

      describe "percent_present" do
        it "returns the percent of days present for a student" do
          expect(@student.percent_present(@course)).to eq(80.0)
          expect(@student.percent_present(@course2)).to eq(60.0)
          expect(@student.percent_present).to eq(70.0)
        end
      end

      describe "percent_absent" do
        it "returns the percent of days absent for a student" do
          expect(@student.percent_absent(@course)).to eq(20.0)
          expect(@student.percent_absent(@course2)).to eq(40.0)
          expect(@student.percent_absent).to eq(30.0)
        end
      end

      describe "total_absences" do
        it "returns the number of days absent for a student" do
          expect(@student.total_absences(@course)).to eq(2)
          expect(@student.total_absences(@course2)).to eq(4)
          expect(@student.total_absences).to eq(6)
        end
      end
    end
  end

  describe "class methods" do
    before :each do
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
    end

    describe ".random_groups()" do
      it "gives random groups based on an input number" do

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
        Student.first.attendances.create(course_id: @course.id, created_at: DateTime.now.midday , attendance: "present")
        Student.second.attendances.create(course_id: @course.id, created_at: DateTime.now.midday , attendance: "present_no_response")
        Student.third.attendances.create(course_id: @course.id, created_at: DateTime.now.midday , attendance: "tardy")
        Student.fourth.attendances.create(course_id: @course.id, created_at: DateTime.now.midday , attendance: "absent")
        Student.last.attendances.create(course_id: @course.id, created_at: DateTime.now.midday , attendance: "absent_with_response")
        expect(Student.present_students.include?(Student.fourth)).to be false
        expect(Student.present_students.include?(Student.fifth)).to be false
        expect(Student.present_students.count).to eq(3)
      end
    end
  end
end
