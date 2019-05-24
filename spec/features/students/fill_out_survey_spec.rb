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
    click_on 'Start Survey'
  end

  after :each do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  it 'can submit a survey' do

    # binding.pry
  # with(
  #   headers: {
  #  'Accept'=>'*/*',
  #  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #  'User-Agent'=>'Faraday v0.15.4'
  #   }).
  # to_return(status: 200, body: '', headers: {})
    # stub_request(:get, domain + endpoint).to_return(body: body)

    save_and_open_page
    choose "1"
    choose "5"

    click_on "Submit"
    binding.pry
    expect(current_path).to eq(student_completed_survey_path)
    expect(page).to have_content("Thank You!")
    # At this point there is a course_id and student_id in the session

    # Ultimately, I would like to pass the `course_id` to sinatra and recieve the list of Q&As
    # For the moment, pass a hard-coded list of question IDs

    # From that list of questions, create a Facade to pass to the view
    # The facade will have a list of questions in `questions`.
    # Each question has "text", "id" and list of "choices"
    # If there is only one choice, give a text box
    # if there are multiple choices, offer all choices As radio buttons (choices have text and id)
    # If there aren't any choices, give a text box.

    # Give a submit button
  end
end
