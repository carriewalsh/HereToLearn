require 'rails_helper'

RSpec.describe GoogleService do
  it "can get information", :vcr do
    statement = "I'm angry"
    service = GoogleService.new(statement)

    return_value = service.get_rating

    expect(return_value).to be_a(Hash)
    expect(return_value).to have_key("documentSentiment")
  end
end
