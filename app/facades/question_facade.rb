class QuestionFacade
  def initialize(question_list)
    @question_list = question_list
  end

  def questions
    @question_list.map do |question_number|
      Question.new(question_data[question_number])
    end
  end

  private

  def question_data
    @_question_data ||= question_service.questions_by_ids(@question_list)
    @_question_data.group_by{ |q| q['id']}
  end

  def question_service
    @_question_service ||= QuestionService.new
  end
end
