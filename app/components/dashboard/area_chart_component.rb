# frozen_string_literal: true

module Dashboard
  class AreaChartComponent < ViewComponent::Base
    def initialize(title:, value:, description:, percentage_change: nil, trend: :up, period_options: [], report_link: nil, chart_data: {})
      @title = title
      @value = value
      @description = description
      @percentage_change = percentage_change
      @trend = trend # :up or :down
      @period_options = period_options.presence || default_period_options
      @report_link = report_link
      @chart_data = chart_data
    end

    def dropdown_id
      @dropdown_id ||= "dropdown-#{SecureRandom.hex(4)}"
    end

    def trend_icon
      if @trend == :up
        <<~SVG.html_safe
          <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v13m0-13 4 4m-4-4-4 4"/>
          </svg>
        SVG
      else
        <<~SVG.html_safe
          <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19V5m0 14-4-4m4 4 4-4"/>
          </svg>
        SVG
      end
    end

    def trend_color_class
      @trend == :up ? "text-fg-success" : "text-fg-destructive"
    end


    private

    def default_period_options
      [
        { label: "Yesterday", value: "yesterday" },
        { label: "Today", value: "today" },
        { label: "Last 7 days", value: "last_7_days" },
        { label: "Last 30 days", value: "last_30_days" },
        { label: "Last 90 days", value: "last_90_days" }
      ]
    end

    def default_series
      [ { name: "Data", data: [ 6500, 6418, 6456, 6526, 6356, 6456 ] } ]
    end

    def default_categories
      [ "01 February", "02 February", "03 February", "04 February", "05 February", "06 February", "07 February" ]
    end
  end
end
