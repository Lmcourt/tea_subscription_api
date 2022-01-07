FactoryBot.define do
  factory :subscription do
    title { Faker::Lorem.word }
    price { Faker::Number.within(range: 5..20 ) }
    status { 0 }
  end
end
