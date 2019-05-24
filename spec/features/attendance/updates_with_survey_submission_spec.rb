require 'rails_helper'

describe 'A student with their e-mail in the system' do
  before :each do
    @student = create(:student)
    stub_omniauth(@student.google_id, @student.first_name, @student.last_name)

    @in_class = create(:course)
    @student.courses << @in_class

    @in_class_code = create(:code, course: @in_class)

    visit '/student'
    fill_in :code, with: @in_class_code.code

    endpoint = '/api/v1/questions?ids=1,2'
    domain = 'http://surveyapp.com'
    body =  File.open('./api_responses/questions.json')

    stub_request(:get, domain + endpoint).to_return(body: body)

    expect(Attendance.count).to eq(0)
    Rails.application.load_tasks
    Rake::Task['attendance:populate'].invoke

    expect(Attendance.count).to eq(1)

    click_on 'Start Survey'

    choose "1"
    choose "5"


  end

  after :each do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  it 'updates attendance after submission' do
    attendance_record = Attendance.find_by(course:@in_class, student:@student)
    expect(attendance_record.attendance). to eq("absent")

    click_on "Submit"
    attendance_record = Attendance.find_by(course:@in_class, student:@student)
    expect(attendance_record.attendance). to eq("present")

  end
end
