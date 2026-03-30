# frozen_string_literal: true

module Ui
  class AreaChartComponent < ViewComponent::Base
    def initialize(series:, categories: [], height: "100%", max_width: "100%", color: nil, stroke_width: 6, chart_options: {})
      @series = series
      @categories = categories
      @height = height
      @max_width = max_width
      @color = color # Si es nil, usará --color-fg-brand del CSS
      @stroke_width = stroke_width
      @custom_chart_options = chart_options
    end

    def chart_id
      @chart_id ||= "area-chart-#{SecureRandom.hex(4)}"
    end

    def chart_data
      {
        series: @series,
        categories: @categories,
        height: @height,
        maxWidth: @max_width,
        color: @color,
        strokeWidth: @stroke_width,
        customOptions: @custom_chart_options
      }.to_json
    end
  end
end
