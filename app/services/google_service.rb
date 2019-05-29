class GoogleService
  def initialize(statement)
    @statement = statement
  end

  def get_rating
    conn = Faraday.new("https://language.googleapis.com/v1/documents:analyzeSentiment?fields=documentSentiment&key=#{ENV['GOOGLE-API-KEY']}") do |f|
      # f.headers["fields"] = "documentSentiment%2Clanguage%2Csentences"
      # f.headers["key"] = ENV["GOOGLE-API-KEY"]
      f.adapter Faraday.default_adapter
    end
    body = {'document': {'type': 'PLAIN_TEXT', 'content': @statement}, 'encodingType': 'UTF8'}.to_json
    # content = @statement

    r = conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = body
    end

    JSON.parse(r.body)
  end
end
