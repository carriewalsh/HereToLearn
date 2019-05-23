require 'rails_helper'

describe 'A student with their e-mail in the system' do
  before :each do
    @user = create(:user)
    stub_omniauth(@user.google_id, @user.first_name, @user.last_name)

    visit '/student'
  end

  after :each do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  describe 'with a valid class code' do
    it 'can access the survey if they are in the class' do

    end

    it 'cannot access the survey if they are not in the class' do

    end

  end
  describe 'without a vaild class code' do
    it 'cannot access the survey' do

    end
  end
end
