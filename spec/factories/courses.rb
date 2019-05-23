FactoryBot.define do
  factory :course do
    name { Faker::IndustrySegments.sector }
    period { Faker::Number.number(1) }
    start_time { Faker::Time.between(Date.today, Date.today, :morning) }
    end_time { Faker::Time.between(Date.today, Date.today, :afternoon) }
  end
end
