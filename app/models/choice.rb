class Choice
  attr_reader :id, :text
  def initialize(choice_info)
    @text = choice_info["choice"]
    @id = choice_info["choice_id"]
  end
end
