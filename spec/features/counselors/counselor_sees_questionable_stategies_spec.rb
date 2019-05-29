require 'rails_helper'

RSpec.describe "counselor strategies" do
  context "as a counselor on my dashboard" do
    it "can unflag or delete suspect reviews" do
      student = create(:student)
      counselor = create(:teacher, role: :counselor)
      teacher = create(:teacher, role: :teacher)
      strategy = student.strategies.create(teacher: teacher, strategy: "great student!")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(counselor)

      visit dashboard_path
      save_and_open_page
      binding.pry
    end
  end
end
