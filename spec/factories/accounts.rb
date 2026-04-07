FactoryBot.define do
  factory :account do
    association :user
    sequence(:name) { |n| "#{Faker::Bank.name} #{n}" }
    kind { Account.kinds.keys.sample }
    active { false }
  end
end
