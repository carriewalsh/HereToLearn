FactoryBot.define do
  factory :attendance do
    student { nil }
    course { nil }
    attendance { 1 }
  end
end
