require 'rails_helper'

describe 'A student with their e-mail in the system' do
  before :each do
    @student = create(:student)

    stub_omniauth(@student.google_id, @student.first_name, @student.last_name)

    @on_time_class = create(:course, start_time: DateTime.now)
    @late_class = create(:course, start_time: 6.minutes.ago)
    @absent_class = create(:course, start_time: 1.hour.ago, end_time: 15.minutes.ago)

    @student.courses << @on_time_class
    @student.courses << @late_class
    @student.courses << @absent_class

    @on_time_code = create(:code, course: @on_time_class)
    @late_code = create(:code, course: @late_class)
    @absent_code = create(:code, course: @absent_class)

    Rake::Task['attendance:populate'].execute

    endpoint = '/api/v1/questions?ids=1,2'
    domain = 'http://surveyapp.com'
    body =  File.open('./api_responses/questions.json')

    stub_request(:get, domain + endpoint).to_return(body: body)
    visit '/student'
  end

  it 'marks as present before 5 mins from start of course' do

    fill_in :code, with: @on_time_code.code


    click_on 'Start Survey'

    choose "1"
    choose "5"

    click_on "Submit"

    attendance = Attendance.find_by(course: @on_time_class, student: @student)

    expect(attendance.attendance).to eq("present")
  end

  it 'marks as tardy after 5 mins from start of course' do
    fill_in :code, with: @late_code.code


    click_on 'Start Survey'

    choose "1"
    choose "5"

    click_on "Submit"

    attendance = Attendance.find_by(course: @late_class, student: @student)

    expect(attendance.attendance).to eq("tardy")
  end

  it 'does not change attendance status after end of class' do
    fill_in :code, with: @absent_code.code


    click_on 'Start Survey'

    choose "1"
    choose "5"

    click_on "Submit"

    attendance = Attendance.find_by(course: @absent_class, student: @student)

    # Expectation here is 'nil' because we do not want the status to change;
    # e.g. maybe the teacher manually entered in some status, and the student decided
    # to fill the survey, thus the status shouldn't change
    expect(attendance.attendance).to eq(nil)
  end

end
