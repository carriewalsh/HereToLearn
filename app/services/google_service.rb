class GoogleService
  def initialize(statement)
    @statement = statement
  end

  def get_rating
    conn = Faraday.new("https://language.googleapis.com/v1/documents:analyzeSentiment?fields=documentSentiment&key=#{ENV['GOOGLE-API-KEY']}") do |f|
      f.adapter Faraday.default_adapter
    end

    body = {'document': {'type': 'PLAIN_TEXT', 'content': @statement}, 'encodingType': 'UTF8'}.to_json
    response = conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = body
    end

    value = JSON.parse(response.body, symbolize_names: true)
    return value[:documentSentiment][:score]
  end
end
