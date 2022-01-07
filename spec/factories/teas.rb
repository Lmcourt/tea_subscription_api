FactoryBot.define do
  factory :tea do
    title { Faker::JapaneseMedia::StudioGhibli.movie }
    description { Faker::JapaneseMedia::StudioGhibli.quote }
    temperature { Faker::Number.within(range: 100..150) }
    brew_time { Faker::Number.within(range: 1..5) }
  end
end
