FactoryBot.define do
  factory :item do
    name { Faker::Music::Rush.album }
    description { Faker::Books::Dune.quote }
    unit_price { Faker::Number.within(range: 50..4000) }
    association :merchant
  end
end
