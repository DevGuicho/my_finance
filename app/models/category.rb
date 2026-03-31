class Category < ApplicationRecord
  belongs_to :user

  enum :kind, { income: 1, expense: 2 }

  validates :name, presence: true
  validates :kind, presence: true

  before_validation :set_default_active, on: :create

  private

  def set_default_active
    self.active = true if active.nil?
  end
end
