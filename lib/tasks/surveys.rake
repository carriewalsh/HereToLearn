namespace :surveys do
  desc 'update stubs for tests from surveys'
  task :update_stubs, [:domain] => :environment do |t, args|
    domain = args[:domain]

    questions = '/api/v1/questions'
    q_and_a = '/api/v1/q_and_a?question_id=1,2'
    responses = '/api/v1/responses'

    json_data = [questions, q_and_a, responses].map do |uri|
      JSON(Faraday.get(domain+uri).body, symbolize_names: true)
    end

    names = %w(questions q_and_a responses)

    json_data.zip(names).each do |data, name|
      File.open("api_responses/#{name}.json", 'w') do |f|
        f.write(data)
      end
    end

  end
end
