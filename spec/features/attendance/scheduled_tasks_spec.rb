require 'rails_helper'

describe 'Attendance' do
  before :each do
    @student = create(:student)
    @course = create(:course)
    @student.courses << @course
    @schedule = Whenever::Test::Schedule.new(file:'config/schedule.rb')
  end

  it 'has a 2:00am job scheduled to create attendance_records, and class codes on all week days' do
    course_count = Course.count
    expect( @schedule.jobs[:rake].first[:task]).to eq('attendance:populate')
    expect( @schedule.jobs[:rake].first[:every]).to eq([:weekday, {at: '2:00'}])

    expect( @schedule.jobs[:rake].second[:task]).to eq('attendance:generate_codes')
    expect( @schedule.jobs[:rake].second[:every]).to eq([:weekday, {at: '2:00'}])
    expect( @schedule.jobs[:rake].count).to eq(course_count+2)
  end

  it 'has a job scheduled for 5 minutes after class starts to mark students as absent' do
    expect(@schedule.jobs[:rake].last[:task]).to eq("attendance:mark_absent[#{@course.id}]")
    absent_time = Time.strptime(@course.start_time, '%H%M') + 5.minutes
    schedule_time = absent_time.hour.to_s + ":" + absent_time.min.to_s
    expect(@schedule.jobs[:rake].last[:every]).to eq([:weekday, at: schedule_time])
  end
end
