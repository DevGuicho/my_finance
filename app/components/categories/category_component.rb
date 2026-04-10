# frozen_string_literal: true

module Categories
  class CategoryComponent < ViewComponent::Base
    def initialize(category:)
      @category = category
    end

    private

    attr_reader :category

    def category_color
      category.income? ? "green" : "red"
    end

    def category_badge_color
      category.income? ? "success" : "danger"
    end

    def category_total
      @category_total ||= Money.new(category.transactions.sum(:amount_cents), "MXN")
    end

    def number_of_transactions
      category.transactions.count
    end
  end
end
