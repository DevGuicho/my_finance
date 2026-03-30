FactoryBot.define do
  factory :transaction do
    kind { 1 }
    description { "MyString" }
    notes { "MyText" }
    occurred_on { "2026-03-29" }
  end
end
