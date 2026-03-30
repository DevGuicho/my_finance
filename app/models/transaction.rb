class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :account

  enum :kind, { income: 1, expense: 2 }
end
