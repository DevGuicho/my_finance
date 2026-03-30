# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ui::DonutChartComponent, type: :component do
  let(:series) { [44, 55, 13, 33] }
  let(:labels) { ["Food", "Transport", "Entertainment", "Services"] }

  it "renders the component" do
    render_inline(described_class.new(series: series, labels: labels))

    expect(page).to have_css('[data-controller="donut-chart"]')
  end

  it "generates a unique chart id" do
    component1 = described_class.new(series: series, labels: labels)
    component2 = described_class.new(series: series, labels: labels)

    expect(component1.chart_id).not_to eq(component2.chart_id)
  end

  it "includes series data in chart_data" do
    component = described_class.new(series: series, labels: labels)
    data = JSON.parse(component.chart_data)

    expect(data["series"]).to eq(series)
  end

  it "includes labels in chart_data" do
    component = described_class.new(series: series, labels: labels)
    data = JSON.parse(component.chart_data)

    expect(data["labels"]).to eq(labels)
  end

  it "uses default height when not specified" do
    component = described_class.new(series: series, labels: labels)
    data = JSON.parse(component.chart_data)

    expect(data["height"]).to eq("100%")
  end

  it "allows custom height" do
    component = described_class.new(series: series, labels: labels, height: "300px")
    data = JSON.parse(component.chart_data)

    expect(data["height"]).to eq("300px")
  end

  it "allows custom colors" do
    colors = ["#FF6384", "#36A2EB", "#FFCE56", "#4BC0C0"]
    component = described_class.new(series: series, labels: labels, colors: colors)
    data = JSON.parse(component.chart_data)

    expect(data["colors"]).to eq(colors)
  end

  it "includes custom chart options" do
    custom_options = { legend: { position: "right" } }
    component = described_class.new(series: series, labels: labels, chart_options: custom_options)
    data = JSON.parse(component.chart_data)

    expect(data["customOptions"]).to eq(custom_options.deep_stringify_keys)
  end
end

