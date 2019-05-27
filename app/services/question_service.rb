class QuestionService
  def initialize

  end

  def json(body)
    JSON.parse(body, symbolize_name: true)['data']
  end

  def questions_by_ids(question_list)
    response = conn.get('/api/v1/q_and_a', { question_id: question_list.join(",") })
    json(response.body)
  end

  def conn
    Faraday.new('http://surveyapp.com') do |f|
      f.adapter Faraday.default_adapter
    end
  end
end
