FactoryBot.define do
  factory :subscription do
    title { "MyString" }
    price { 1 }
    status { false }
    frequency { "MyString" }
    tea { nil }
    customer { nil }
  end
end
