require "rails_helper"

describe StudentCourse, type: :model do
  describe "relationships" do
    it { should belong_to :course }
    it { should belong_to :student }
  end
end
