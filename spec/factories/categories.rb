FactoryBot.define do
  factory :category do
    name { "MyString" }
    kind { 1 }
    active { false }
    user { nil }
  end
end
