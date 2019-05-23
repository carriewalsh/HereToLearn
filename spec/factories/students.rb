FactoryBot.define do
  factory :student do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    student_id { Faker::Number.number(6) }
    google_id {Faker::Number.number(10)}
  end
end
