require 'rails_helper'

describe 'A student with their e-mail in the system' do
  before :each do
    @student = create(:student)
    stub_omniauth(@student.google_id, @student.first_name, @student.last_name)

    @in_class = create(:course)
    @student.courses << @in_class

    @in_class_code = create(:code, course: @in_class)
    @out_of_class = create(:course)
    @out_of_class_code = create(:code, course: @out_of_class)

    endpoint = '/api/v1/q_and_a?question_id=1,2'
    domain = 'http://surveyapp.com'
    body =  File.open('./api_responses/q_and_a.json')

    stub_request(:get, domain + endpoint).to_return(body: body)

    visit '/student'
    expect(current_path).to eq(student_class_code_path)
  end

  after :each do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  describe 'with a valid class code' do
    it 'can access the survey if they are in the class' do
      fill_in :code, with: @in_class_code.code
      click_on 'Start Survey'

      expect(current_path).to eq(student_survey_path)
    end

    it 'cannot access the survey if they are not in the class' do
      fill_in :code, with: @out_of_class_code.code
      click_on 'Start Survey'

      expect(page).to have_content("Invalid Code")
    end

  end
  describe 'without a vaild class code' do
    it 'cannot access the survey' do
      fill_in :code, with: "YAY"
      click_on 'Start Survey'

      expect(page).to have_content("Invalid Code")
    end
  end
end
