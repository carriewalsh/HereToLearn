require 'rails_helper'

describe 'Attendance' do
  before :each do
    5.times do
      course = create(:course)
      students = create_list(:student, 5)
      students.each { |s| s.courses << course }
    end
  end

  it 'attendance:populate' do
    expect(Attendance.count).to eq(0)
    Rake::Task['attendance:populate'].execute
    expect(Attendance.count).to eq(25)

    students = Student.all

    students.each do |s|
      student_id = s.id
      expect(s.courses.count).to eq(1)
      course_id = s.courses.first.id
      parameters = {student_id: student_id, course_id: course_id}
      attendance_record = Attendance.where(parameters)

      expect(attendance_record.count).to eq(1)
      expect(attendance_record.first.attendance).to eq(nil)
    end
  end

  it 'attendance:generate_codes' do
    expect(Code.count).to eq(0)
    Rake::Task['attendance:generate_codes'].execute
    expect(Code.count).to eq(5)

    courses = Course.all

    courses.each do |c|
      codes = Code.where(course_id: c.id)
      expect(codes.count).to eq(0)

      expect(code.first.code).not_to eq(nil)
    end
  end

  it 'attendance:mark_absent[class_id]' do

  end
end
