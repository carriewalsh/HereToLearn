FactoryBot.define do
  factory :course do
    name { Faker::IndustrySegments.sector }
    period { Faker::Number.number(1) }
    start_time { Faker::Time.between(Date.today, Date.today, :morning) }
    end_time { start_time + 50.minutes }
  end
end
