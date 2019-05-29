class GoogleService
  def initialize(statement)
    @statement = statement
  end

  def get_rating
    conn = Faraday.new("https://language.googleapis.com") do |f|
      f.headers["fields"] = "documentSentiment%2Clanguage%2Csentences"
      f.headers["key"] = ENV["GOOGLE-API-KEY"]
      f.adapter Faraday.default_adapter
    end
    response = conn.post "/v1/documents:analyzeSentiment", {:document => {:type => "PLAIN_TEXT", :content => @content}, :encodingType => "UTF8"}
    binding.pry
  end
end
