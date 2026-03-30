# frozen_string_literal: true

class Ui::CardComponent < ViewComponent::Base
  def initialize(
    class: nil,
    padding: "p-6",
    shadow: "shadow-xs",
    border: true,
    rounded: "rounded-base",
    background: "bg-neutral-primary-soft",
    max_width: nil,
    width: nil,
    **html_options
  )
    @custom_class = binding.local_variable_get(:class)
    @padding = padding
    @shadow = shadow
    @border = border
    @rounded = rounded
    @background = background
    @max_width = max_width
    @width = width
    @html_options = html_options
  end

  def component_classes
    classes = [
      @background,
      @padding,
      @shadow,
      @rounded,
      ("border border-default" if @border),
      @max_width,
      @width,
      @custom_class
    ].compact

    classes.join(" ")
  end

  def html_attributes
    @html_options.merge(class: component_classes)
  end
end
