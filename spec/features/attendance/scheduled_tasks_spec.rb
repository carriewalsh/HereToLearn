require 'rails_helper'

describe 'Attendance' do
  before :each do
    @student = create(:student)
    course = create(:course)
    @student.courses << course
  end

  it 'has a 2:00am job scheduled to create attendance_records for all week days' do
    schedule = Whenever::Test::Schedule.new(file:'config/schedule.rb')
    
    course_count = Course.count
    expect( schedule.jobs[:rake].first[:task]).to eq('attendance:populate')
    expect( schedule.jobs[:rake].first[:every]).to eq([:weekday, {at: '2:00'}])

    expect(schedule.jobs[:rake].count).to eq(course_count+1)

  end

  it 'has a task scheduled 5 minutes after the course start to mark students absent' do
  end
end
