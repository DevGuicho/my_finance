# frozen_string_literal: true

module Categories
  class CategoryComponent < ViewComponent::Base
    def initialize(category:)
      @category = category
    end


    private

    attr_reader :category
  end
end
