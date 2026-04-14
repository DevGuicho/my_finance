module ApplicationHelper
  def sidebar_active?(section)
    case section
    when :dashboard
      controller_name == "dashboard"
    when :transactions
      controller_name == "transactions"
    when :accounts
      controller_name == "accounts"
    when :categories
      controller_name == "categories"
    when :settings
      controller_name == "settings"
    else
      false
    end
  end

  def sidebar_link_classes(active)
    base = "flex items-center p-2 text-base font-normal rounded-lg group transition-colors"
    inactive = "text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700"
    active_state = "text-fg-brand bg-brand-subtle dark:text-white dark:bg-gray-700"

    [base, (active ? active_state : inactive)].join(" ")
  end
end
