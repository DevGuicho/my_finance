# app/components/ui/modal_component.rb
module Ui
  class ModalComponent < ViewComponent::Base
    renders_one :header
    renders_one :body
    renders_one :footer

    SIZES = {
      sm: "max-w-md",
      md: "max-w-lg",
      lg: "max-w-2xl",
      xl: "max-w-4xl",
      full: "max-w-7xl"
    }.freeze

    attr_reader :id, :title, :size, :close_on_backdrop, :close_on_escape

    def initialize(id:, title: nil, size: :md, close_on_backdrop: true, close_on_escape: true)
      @id = id
      @title = title
      @size = size.to_sym
      @close_on_backdrop = close_on_backdrop
      @close_on_escape = close_on_escape
    end

    def width_class
      SIZES.fetch(size, SIZES[:md])
    end
  end
end
