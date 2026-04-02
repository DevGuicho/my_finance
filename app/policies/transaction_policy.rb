# frozen_string_literal: true

class TransactionPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def permitted_attributes
    [ :amount, :occurred_on, :description, :kind, :account_id, :category_id ]
  end
end
