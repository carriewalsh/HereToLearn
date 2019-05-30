require 'rails_helper'

RSpec.describe "as a counselor" do
  context "on my dashboard" do
    it "can click a link to be taken to the graphs page" do
      counselor = create(:teacher, role: 'counselor')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(counselor)

      visit counselor_dashboard_path

      click_link("View student metrics")

      expect(current_path).to eq(counselor_student_metrics_path)
    end
  end
end
