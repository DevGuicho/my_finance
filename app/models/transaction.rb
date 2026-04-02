class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :account

  monetize :amount_cents

  enum :kind, { income: 1, expense: 2 }
end
