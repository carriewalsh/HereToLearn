FactoryBot.define do
  factory :course do
    name { Faker::IndustrySegments.sector }
    period { Faker::Number.number(1) }
    start_time { (7+rand(7))*100 }
    end_time { (Time.parse(start_time) + 50.minutes).strftime("%H:%M") }
  end
end
