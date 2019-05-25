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
      it "shows the value of TODAY's attendance" do
        today = DateTime.now.beginning_of_day
        yesterday = today-1

        student = create(:student)
        course = student.courses.create(name: "PE", period: "1", start_time: "2019-05-21 8:00:00", end_time: "2019-05-21 9:00:00")

        yesterday_att = student.attendances.create(course_id: course.id, created_at: yesterday, attendance: :absent)
        today_att = student.attendances.create(course_id: course.id, created_at: today, attendance: :present)

        expect(student.todays_attendance).to eq(:present)
      end
    end
  end
end
