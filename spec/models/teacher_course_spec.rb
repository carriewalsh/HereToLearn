require "rails_helper"

describe TeacherCourse, type: :model do
  describe "relationships" do
    it { should belong_to :course }
    it { should belong_to :teacher }
  end
end
