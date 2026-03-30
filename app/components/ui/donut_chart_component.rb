# frozen_string_literal: true

module Ui
  class DonutChartComponent < ViewComponent::Base
    def initialize(series:, labels: [], height: "100%", max_width: "100%", colors: nil, chart_options: {})
      @series = series
      @labels = labels
      @height = height
      @max_width = max_width
      @colors = colors # Si es nil, usará colores por defecto
      @custom_chart_options = chart_options
    end

    def chart_id
      @chart_id ||= "donut-chart-#{SecureRandom.hex(4)}"
    end

    def chart_data
      {
        series: @series,
        labels: @labels,
        height: @height,
        maxWidth: @max_width,
        colors: @colors,
        customOptions: @custom_chart_options
      }.to_json
    end
  end
end
