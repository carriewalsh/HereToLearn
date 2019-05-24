require 'rails_helper'

describe 'Attendance' do
  before :each do
    @student = create(:student)
  end

  it 'has a 2:00am job scheduled to create attendance_records for all week days' do

  end

  it 'has a task scheduled 5 minutes after the course start to mark students absent' do
    course = create(:course)
    @student.courses << course
  end
end
