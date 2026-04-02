# frozen_string_literal: true

class Ui::FilterTabsComponent < ViewComponent::Base
  def initialize(tabs: [], active_tab: nil, **html_options)
    @tabs = tabs
    @active_tab = active_tab || tabs.first
    @html_options = html_options
  end

  def active?(tab)
    tab == @active_tab
  end

  def button_classes(tab)
    base_classes = "block px-4 py-2 rounded-lg transition-all duration-200 cursor-pointer"
    active_classes = "bg-white text-gray-900 shadow"
    inactive_classes = "hover:text-gray-700"

    active?(tab) ? "#{base_classes} #{active_classes}" : "#{base_classes} #{inactive_classes}"
  end
end
