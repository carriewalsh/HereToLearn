require 'rails_helper'
describe "API prediction calls" do
  it 'sends a student ID' do
    will= Student.create!(first_name: "William", last_name: "Peterson", student_id: "250923", google_id: "107113987859408235003")

    get "/api/v1/machinelearning/results?student_id=#{will.id}"

    expect(response).to be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:data][:attributes][:student_id]).to eq("250923")
  end
end
