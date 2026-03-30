class Category < ApplicationRecord
  belongs_to :user

  enum :kind, { income: 1, expense: 2 }
end
