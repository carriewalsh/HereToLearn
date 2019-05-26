require "rails_helper"

describe Teacher, type: :model do
  describe "validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  describe "relationships" do
    it { should have_many :teacher_courses }
    it { should have_many :courses }
  end
end
