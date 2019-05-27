require "rails_helper"

describe Strategy, type: :model do
  describe "relationships" do
    it { should belong_to :student }
    it { should belong_to :teacher }
  end
end
