FactoryBot.define do
  tactory :teacher do
    first_name { Faker::Creature::Dog.name }
    last_name { Faker::Artist.name }
    email { Faker::Internet.email }
    password { Faker::Color.color_name }
  end
end
