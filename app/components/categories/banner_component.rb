# frozen_string_literal: true

module Categories
  class BannerComponent < ViewComponent::Base
    def initialize(categories:)
      @categories = categories
    end

    private

    attr_reader :categories

    def total_categories
      @total_categories ||= categories.count
    end

    def income_categories
      @income_categories ||= categories.income.size
    end

    def expenses_categories
      @expenses_categories ||= categories.expense.size
    end
  end
end
