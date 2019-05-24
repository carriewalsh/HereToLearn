class QuestionFacade
  def initialize(question_list)
    @question_list = question_list
  end

  def questions
    question_data.map do |answer_list|
      Question.new(answer_list)
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
