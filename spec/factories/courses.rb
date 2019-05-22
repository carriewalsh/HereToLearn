FactoryBot.define do
  tactory :course do
    name { Faker::IndustrySegments.sector }
    period { Faker::Number.number(1) }
    start_time { Faker::Time.between(Date.today,:morning,Date.today,:afternoon) }
    end_time { Faker::Time.between(Date.today,:evening, Date.today, :midnight) }
  end
end
