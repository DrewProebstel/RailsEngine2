FactoryBot.define do
  factory :merchant do
    name { Faker::Games::Overwatch.hero }
  end
end
