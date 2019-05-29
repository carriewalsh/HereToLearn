require "rails_helper"

describe StrategyReference, type: :model do
  describe "validations" do
    it { should validate_presence_of :built_in }
  end
end
