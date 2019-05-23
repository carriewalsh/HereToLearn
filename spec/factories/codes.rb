FactoryBot.define do
  factory :code do
    code { SecureRandom.hex(2) }
    course { nil }
  end
end
