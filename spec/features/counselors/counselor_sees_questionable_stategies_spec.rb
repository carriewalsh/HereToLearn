require 'rails_helper'

RSpec.describe "counselor strategies" do
  context "as a counselor on my dashboard" do
    it "can unflag or delete suspect reviews" do
      student = create(:student)
      counselor = create(:teacher, role: :counselor)
      teacher = create(:teacher, role: :teacher)
      teacher2 = create(:teacher, role: :teacher)
      good_strategy = student.strategies.create(teacher: teacher, strategy: "great student!")
      bad_strategy = student.strategies.create(teacher: teacher2, strategy: "this kid sucks!", flagged: true)
      oops_strategy = student.strategies.create(teacher: teacher2, strategy: "this kid is awesome!", flagged: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(counselor)

      visit counselor_dashboard_path

      within '.flagged-strategies' do
        expect(page).to have_content(bad_strategy.strategy)
        expect(page).to have_content(oops_strategy.strategy)
        expect(page).to_not have_content(good_strategy.strategy)
      end

      within(page.all('.strategy')[0]) do
        click_on 'Delete this strategy'
      end

      expect(current_path).to eq(counselor_dashboard_path)
      expect(page).to_not have_content(bad_strategy.strategy)

      within(page.all('.strategy')[0]) do
        click_on 'Approve this strategy'
      end

      expect(current_path).to eq(counselor_dashboard_path)
      expect(page).to_not have_content(oops_strategy.strategy)
    end
  end
end
