require "rails_helper"

describe Student, type: :model do
  describe "validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :google_id }
    it { should validate_presence_of :student_id }
    it { should validate_uniqueness_of :student_id }
  end

  describe "relationships" do
    it { should have_many :student_courses }
    it { should have_many :courses }
  end
end
