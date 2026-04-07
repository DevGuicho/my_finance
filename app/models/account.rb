class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  monetize :current_balance_cents

  validates :name, presence: true
  validates :current_balance_cents, presence: true
  validates :kind, presence: true

  enum :kind, {
    cash: 1,
    debit: 2,
    credit: 3,
    savings: 4,
    other: 5
  }
end
