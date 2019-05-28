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

    endpoint = '/api/v1/q_and_a?question_id=1,2'
    domain = 'https://aqueous-caverns-33840.herokuapp.com'
    body =  File.open('./api_responses/q_and_a.json')
    stub_request(:get, domain + endpoint).to_return(body: body)

    expect(Attendance.count).to eq(0)
    Rake::Task['attendance:populate'].execute
    expect(Attendance.count).to eq(1)

    click_on 'Start Survey'
  end

  after :each do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  it 'can submit a survey' do

    choose "1"
    choose "5"

    click_on "Submit"

    expect(current_path).to eq(student_completed_survey_path)
    expect(page).to have_content("Thank You!")

  end
end
