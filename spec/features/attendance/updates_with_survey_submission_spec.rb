require 'rails_helper'

describe 'A student with their e-mail in the system' do
  before :each do
    @student = create(:student)
    @absent_student = create(:student)
    stub_omniauth(@student.google_id, @student.first_name, @student.last_name)

    @in_class = create(:course, start_time: convert_to_string(DateTime.now))
    @student.courses << @in_class
    @absent_student.courses << @in_class

    @in_class_code = create(:code, course: @in_class)

    visit '/student'
    fill_in :code, with: @in_class_code.code

    endpoint = '/api/v1/q_and_a?question_id=1,2'
    domain = 'https://aqueous-caverns-33840.herokuapp.com'
    body =  File.open('./api_responses/q_and_a.json')

    stub_request(:get, domain + endpoint).to_return(body: body)

    expect(Attendance.count).to eq(0)
    Rake::Task['attendance:populate'].execute

    expect(Attendance.count).to eq(2)

    click_on 'Start Survey'

    choose "1"
    choose "5"


  end

  after :each do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  it 'updates attendance after submission' do
    attendance_record = Attendance.find_by(course:@in_class, student:@student)
    expect(attendance_record.attendance). to eq(nil)

    click_on "Submit"
    attendance_record.reload

    expect(attendance_record.attendance). to eq("present")

    expect(Attendance.where(attendance: 'absent').count).to eq(0)
    Rake::Task["attendance:mark_absent"].execute(course_id: @in_class.id)
    expect(Attendance.where(attendance: 'absent').count).to eq(1)
    expect(Attendance.where(attendance: 'present').count).to eq(1)

  end
end
