FactoryBot.define do
  factory :account do
    association :user
    sequence(:name) { |n| "Account #{n}" }
    kind { Account.kinds.keys.first }
    active { false }
  end
end
