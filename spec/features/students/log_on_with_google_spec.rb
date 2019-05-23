require 'rails_helper'

describe 'A student with their e-mail in the system' do
  after :each do
    # Cleanup OAuth mock
    OmniAuth.config.mock_auth[:google] = nil
  end

  it 'can log on with google account via OAuth' do
    user = create(:student)

    stub_omniauth(user.google_id, user.first_name, user.last_name)
    visit '/student'

    expect(current_path).to eq(class_code_path)
    expect(page).to have_content("Successfully Logged-In")
  end

  it 'cannot log on with information not in student table' do
    user = attributes_for(:student)

    stub_omniauth(user[:google_id], user[:first_name], user[:last_name])
    visit '/student'

    expect(current_path).to eq(unregistered_path)
    expect(page).to have_content("You are not registered in our system, please contact your teacher")
  end
end
