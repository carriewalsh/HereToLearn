class Question
  attr_reader :id, :text, :choices
  def initialize(choice_list)
    @id = choice_list[0]["id"]
    @text = choice_list[0]['attributes']['question']
    @choices = choice_list.map{ |c| Choice.new(c['attributes'])}
  end
end
