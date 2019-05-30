require 'rails_helper'

RSpec.describe Attendance, type: :model do
  describe "relationships" do
    it { should belong_to :student }
    it { should belong_to :course }
  end

  describe "instance methods" do
    describe "attendance_percent_this_date" do
      it "returns the total percent attendance on a given date" do

        today = DateTime.now
        student = create(:student)
        course = create(:course)
        att1 = student.attendances.create(attendance: "present",course_id: course.id, created_at: today - 5.days)
        att2 = student.attendances.create(attendance: "present",course_id: course.id, created_at: today - 4.days)
        att3 = student.attendances.create(attendance: "present",course_id: course.id, created_at: today - 3.days)
        att4 = student.attendances.create(attendance: "absent",course_id: course.id, created_at: today - 2.days)
        att5 = student.attendances.create(attendance: "absent",course_id: course.id, created_at: today - 1.day)
        att6 = student.attendances.create(attendance: "absent",course_id: course.id, created_at: today)

        expect(att2.attendance_percent_this_date).to eq(100.0)
        expect(att4.attendance_percent_this_date).to eq(75.0)
        expect(att6.attendance_percent_this_date).to eq(50.0)
      end
    end
  end
end
