class Account < ApplicationRecord
  belongs_to :user

  monetize :initial_balance_cents

  enum :kind, {
    cash: 1,
    debit: 2,
    credit: 3,
    savings: 4,
    other: 5
  }
end
