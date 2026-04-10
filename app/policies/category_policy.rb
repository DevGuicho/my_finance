# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  def create?
    owner?
  end

  def edit?
    owner?
  end

  def update?
    edit?
  end

  def destroy?
    owner?
  end

  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
