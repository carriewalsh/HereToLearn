require "rails_helper"

describe Course, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :period }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }
  end

  describe "relationships" do
    it { should have_many :student_courses }
    it { should have_many :students }
    it { should have_many :teacher_courses }
    it { should have_many :teachers }
    it { should have_many :attendances }
  end
end
