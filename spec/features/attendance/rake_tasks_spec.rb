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
      expect(codes.count).to eq(1)

      expect(codes.first.code).not_to eq(nil)
    end
  end

  it 'attendance:mark_absent[class_id]' do
    Rake::Task['attendance:populate'].execute

    expect(Attendance.where(attendance: nil).count).to eq(25)
    expect(Attendance.where(attendance: 'absent').count).to eq(0)


    Rake::Task['attendance:mark_absent'].execute(Course.first.id)
    expect(Attendance.where(attendance: nil).count).to eq(20)
    expect(Attendance.where(attendance: 'absent').count).to eq(5)

    course = Course.second
    student = course.students.first
    attendance_record = Attendance.find_by(course_id: course.id, student_id: student.id )

    attendance_record.update_attribute(:attendance, "present")
    Rake::Task['attendance:mark_absent'].execute(Course.second.id)

    expect(Attendance.where(attendance: nil).count).to eq(15)
    expect(Attendance.where(attendance: 'absent').count).to eq(9)
    expect(Attendance.where(attendance: 'present').count).to eq(1)

  end
end
